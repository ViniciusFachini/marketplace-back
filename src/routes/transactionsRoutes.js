const express = require('express');
const {
    createTransaction,
    getTransactionById,
    updateTransactionById,
    deleteTransactionById,
    withdrawFromWallet
} = require('../controllers/transactionsController');
const { verifyToken } = require('../middleware/authentication');

const router = express.Router();

router.post('/', verifyToken, createTransaction);
router.get('/:id', verifyToken, getTransactionById);
router.patch('/:id', verifyToken, updateTransactionById);
router.delete('/:id', verifyToken, deleteTransactionById);

router.patch('/:userId/withdraw', verifyToken, withdrawFromWallet)


module.exports = router;
