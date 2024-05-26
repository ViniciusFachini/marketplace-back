const { queryAsync } = require('../db');

const STATUS_CODES = {
    NOT_FOUND: 404,
    BAD_REQUEST: 400,
    INTERNAL_SERVER_ERROR: 500
};

const ERRORS = {
    PRODUCT_NOT_FOUND: 'Product not found',
    PRODUCT_NOT_AVAILABLE: 'Product is not available',
    BUYER_ADDRESS_NOT_FOUND: 'Buyer address not found',
    SELLER_ADDRESS_NOT_FOUND: 'Seller address not found',
    TRANSACTION_NOT_FOUND: 'Transaction not found',
    WALLET_NOT_FOUND: 'Wallet not found',
    INSUFFICIENT_WITHDRAWABLE_FUNDS: 'Insufficient withdrawable funds',
    INSUFFICIENT_BALANCE: 'Insufficient balance',
    INTERNAL_SERVER_ERROR: 'Internal Server Error'
};

const createTransaction = async (req, res) => {
    const {
        buyer_id,
        seller_id,
        product_id,
        quantity,
        total_amount,
        transaction_type,
        payment_method,
        shipping_method,
        status
    } = req.body;

    try {
        const product = await queryAsync('SELECT available FROM products WHERE id = ?', [product_id]);
        if (product.length === 0) {
            return res.status(STATUS_CODES.NOT_FOUND).json({ error: ERRORS.PRODUCT_NOT_FOUND });
        }
        if (product[0].available === 0) {
            return res.status(STATUS_CODES.BAD_REQUEST).json({ error: ERRORS.PRODUCT_NOT_AVAILABLE });
        }

        const buyerAddress = await queryAsync('SELECT address_id FROM user_addresses WHERE user_id = ? AND main_address = 1', [buyer_id]);
        if (buyerAddress.length === 0) {
            return res.status(STATUS_CODES.NOT_FOUND).json({ error: ERRORS.BUYER_ADDRESS_NOT_FOUND });
        }
        const buyer_address_id = buyerAddress[0].address_id;

        const sellerAddress = await queryAsync('SELECT address_id FROM user_addresses WHERE user_id = ? AND main_address = 1', [seller_id]);
        if (sellerAddress.length === 0) {
            return res.status(STATUS_CODES.NOT_FOUND).json({ error: ERRORS.SELLER_ADDRESS_NOT_FOUND });
        }
        const seller_address_id = sellerAddress[0].address_id;

        const result = await queryAsync(
            'INSERT INTO transactions (buyer_id, seller_id, product_id, quantity, total_amount, transaction_type, buyer_address_id, seller_address_id, payment_method, shipping_method, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
            [
                buyer_id,
                seller_id,
                product_id,
                quantity,
                total_amount,
                transaction_type,
                buyer_address_id,
                seller_address_id,
                payment_method,
                shipping_method,
                status
            ]
        );

        const transactionId = result.insertId;

        await queryAsync('UPDATE products SET available = 0 WHERE id = ?', [product_id]);

        if (status === 'Concluído') {
            await updateSellerWalletBalance(seller_id, total_amount);
        }

        res.status(201).json({ message: 'Transaction created successfully', id: transactionId });
    } catch (error) {
        console.error('Error creating transaction:', error);
        res.status(STATUS_CODES.INTERNAL_SERVER_ERROR).json({ error: ERRORS.INTERNAL_SERVER_ERROR });
    }
};

const updateSellerWalletBalance = async (sellerId, amount) => {
    try {
        await queryAsync('UPDATE Wallets SET balance = balance + ? WHERE user_id = ?', [amount, sellerId]);
    } catch (error) {
        console.error('Error updating seller wallet balance:', error);
        throw new Error('Failed to update seller wallet balance');
    }
};

const getTransactionById = async (req, res) => {
    const transactionId = parseInt(req.params.id);
    try {
        const transaction = await queryAsync('SELECT * FROM transactions WHERE id = ?', [transactionId]);

        if (transaction.length === 0) {
            return res.status(STATUS_CODES.NOT_FOUND).json({ error: ERRORS.TRANSACTION_NOT_FOUND });
        }

        res.json(transaction[0]);
    } catch (error) {
        console.error('Error fetching transaction:', error);
        res.status(STATUS_CODES.INTERNAL_SERVER_ERROR).json({ error: ERRORS.INTERNAL_SERVER_ERROR });
    }
};

const updateTransactionById = async (req, res) => {
    const transactionId = parseInt(req.params.id);
    const updates = req.body;
    try {
        const transaction = await queryAsync('SELECT * FROM transactions WHERE id = ?', [transactionId]);
        if (transaction.length === 0) {
            return res.status(STATUS_CODES.NOT_FOUND).json({ error: ERRORS.TRANSACTION_NOT_FOUND });
        }
        const currentStatus = transaction[0].status;
        switch (updates.status) {
            case 'Pagamento Recebido':
                if (currentStatus !== 'Pagamento Recebido') {
                    await updateSellerWalletBalance(transaction[0].seller_id, transaction[0].total_amount);
                }
                break;
            case 'Concluído':
                if (currentStatus !== 'Concluído') {
                    await updateWithdrawAmountOnCompletion(transaction[0].seller_id, transaction[0].total_amount);
                }
                break;
            case 'Reembolsado':
                if (currentStatus !== 'Reembolsado') {
                    await makeRefund(transaction[0].seller_id, transaction[0].total_amount);
                }
                break;
            case 'Cancelado':
                if (currentStatus !== 'Cancelado') {
                    await setProductAvailability(transaction[0].product_id, 1);
                }
                break;
            default:
                break;
        }

        await queryAsync('UPDATE transactions SET ? WHERE id = ?', [updates, transactionId]);

        res.json({ message: 'Transaction updated successfully' });
    } catch (error) {
        console.error('Error updating transaction:', error);
        res.status(STATUS_CODES.INTERNAL_SERVER_ERROR).json({ error: ERRORS.INTERNAL_SERVER_ERROR });
    }
};

const makeRefund = async (sellerId, amount) => {
    try {
        await queryAsync('UPDATE Wallets SET balance = balance - ?, withdrawable_amount = withdrawable_amount - ? WHERE user_id = ?', [amount, amount, sellerId]);
    } catch (error) {
        console.error('Error making refund:', error);
        throw new Error('Failed to make refund');
    }
};

const setProductAvailability = async (productId, availability) => {
    try {
        await queryAsync('UPDATE products SET available = ? WHERE id = ?', [availability, productId]);
    } catch (error) {
        console.error('Error setting product availability:', error);
        throw new Error('Failed to set product availability');
    }
};

const updateWithdrawAmountOnCompletion = async (sellerId, amount) => {
    try {
        await queryAsync(`
            UPDATE Wallets
            SET 
                withdrawable_amount = CASE
                    WHEN withdrawable_amount > 0 THEN withdrawable_amount + ?
                    ELSE ?
                END,
                balance = balance - ?
            WHERE user_id = ?;
        `, [amount, amount, amount, sellerId]);
    } catch (error) {
        console.error('Error updating withdrawable amount:', error);
        throw new Error('Failed to update withdrawable amount');
    }
};

const deleteTransactionById = async (req, res) => {
    const transactionId = parseInt(req.params.id);
    try {
        const result = await queryAsync('DELETE FROM transactions WHERE id = ?', [transactionId]);
        if (result.affectedRows === 0) {
            return res.status(STATUS_CODES.NOT_FOUND).json({ error: ERRORS.TRANSACTION_NOT_FOUND });
        }
        res.json({ message: 'Transaction deleted successfully' });
    } catch (error) {
        console.error('Error deleting transaction:', error);
        res.status(STATUS_CODES.INTERNAL_SERVER_ERROR).json({ error: ERRORS.INTERNAL_SERVER_ERROR });
    }
}

const withdrawFromWallet = async (req, res) => {
    const userId = parseInt(req.params.userId);
    const { amount } = req.body;

    try {
        const wallet = await queryAsync('SELECT * FROM Wallets WHERE user_id = ?', [userId]);
        if (wallet.length === 0) {
            return res.status(STATUS_CODES.NOT_FOUND).json({ error: ERRORS.WALLET_NOT_FOUND });
        }

        const balance = wallet[0].balance;
        const withdrawableAmount = wallet[0].withdrawable_amount;

        if (amount > withdrawableAmount) {
            return res.status(STATUS_CODES.BAD_REQUEST).json({ error: ERRORS.INSUFFICIENT_WITHDRAWABLE_FUNDS });
        }

        await queryAsync('UPDATE Wallets SET withdrawable_amount = withdrawable_amount - ? WHERE user_id = ?', [amount, userId]);

        res.json({ message: 'Withdrawal successful' });
    } catch (error) {
        console.error('Error withdrawing from wallet:', error);
        res.status(STATUS_CODES.INTERNAL_SERVER_ERROR).json({ error: ERRORS.INTERNAL_SERVER_ERROR });
    }
};

module.exports = {
    createTransaction,
    getTransactionById,
    updateTransactionById,
    deleteTransactionById,
    withdrawFromWallet
};
