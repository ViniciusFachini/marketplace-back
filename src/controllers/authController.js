const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
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

/**
 * Controller function for user registration.
 */
const register = async (req, res) => {
  try {
    const { name, email, password, username, phone, user_type, address } = req.body;
    console.log(req.body)

    const userExists = await queryAsync('SELECT * FROM Users WHERE username = ?', [username]);
    const emailExists = await queryAsync('SELECT * FROM Users WHERE email = ?', [email]);

    if (userExists.length > 0) {
      return res.status(400).json({ error: 'Username already in use' });
    }

    if (emailExists.length > 0) {
      return res.status(400).json({ error: 'Email already in use' });
    }

    const hashedPassword = await bcrypt.hash(String(password), 10);

    let userQuery = 'INSERT INTO Users';
    let userFields = '';
    let userPlaceholders = '';
    const userValues = [];

    if (name !== undefined) {
      userFields += 'name, ';
      userPlaceholders += '?, ';
      userValues.push(name);
    }

    if (email !== undefined) {
      userFields += 'email, ';
      userPlaceholders += '?, ';
      userValues.push(email);
    }

    if (password !== undefined) {
      userFields += 'password, ';
      userPlaceholders += '?, ';
      userValues.push(hashedPassword);
    }

    if (username !== undefined) {
      userFields += 'username, ';
      userPlaceholders += '?, ';
      userValues.push(username);
    }

    if (req.body.profilePicture !== undefined) {
      userFields += 'user_image, ';
      userPlaceholders += '?, ';
      userValues.push(req.body.profilePicture);
    }

    if (phone !== undefined) {
      userFields += 'phone, ';
      userPlaceholders += '?, ';
      userValues.push(phone);
    }

    if (user_type !== undefined) {
      userFields += 'user_type, ';
      userPlaceholders += '?, ';
      userValues.push(user_type);
    }

    // Remove the trailing comma and space from fields and placeholders
    userFields = userFields.slice(0, -2);
    userPlaceholders = userPlaceholders.slice(0, -2);

    userQuery += ` (${userFields}) VALUES (${userPlaceholders})`;

    console.log(userQuery, userFields, userPlaceholders)

    const userResult = await queryAsync(userQuery, userValues);

    const userId = userResult.insertId;

    // Address handling (optional)
    if (address) {
      const { street, neighbourhood, number, city, state, postal_code, country, title } = address;

      const addressQuery = 'INSERT INTO Addresses (street, neighbourhood, number, city, state, postal_code, country) VALUES (?, ?, ?, ?, ?, ?, ?)';
      const addressValues = [street, neighbourhood, number, city, state, postal_code, country];

      const addressResult = await queryAsync(addressQuery, addressValues);
      const addressId = addressResult.insertId;

      // Check if this is the first address for the user
      const userAddresses = await queryAsync('SELECT * FROM User_Addresses WHERE user_id = ?', [userId]);
      const mainAddressFlag = userAddresses.length === 0 ? 1 : 0;

      const userAddressQuery = 'INSERT INTO User_Addresses (user_id, address_id, title, main_address) VALUES (?, ?, ?, ?)';
      const userAddressValues = [userId, addressId, title, mainAddressFlag];

      await queryAsync(userAddressQuery, userAddressValues);
    }

    res.status(201).json({ message: 'User registered successfully' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

/**
 * Controller function for user login.
 */
const login = async (req, res) => {
  try {
    const { email, password } = req.body;

    const userResults = await queryAsync('SELECT * FROM Users WHERE email = ?', [email]);

    if (userResults.length > 0) {
      const user = userResults[0];
      const match = await bcrypt.compare(String(password), user.password);

      if (match) {
        const token = jwt.sign(
          { username: user.username, id: user.id },
          process.env.JWT_SECRET,
          { expiresIn: '1h' }
        );

        res.status(200).json({
          token,
          user: {
            id: user.id,
            name: user.name
          },
          expiresIn: 3600
        });
      } else {
        res.status(401).json({ error: 'Invalid credentials' });
      }
    } else {
      res.status(401).json({ error: 'Invalid credentials' });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

/**
 * Controller function to update user information.
 */
const updateUser = async (req, res) => {
  try {
    const { id } = req.params;
    const { currentPassword, email, newPassword, phone } = req.body;
    const profilePicture = req.body.imagePath;

    // Check if the user exists
    const userResults = await queryAsync('SELECT * FROM Users WHERE id = ?', [id]);
    if (userResults.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    const user = userResults[0];

    // Check if the provided current password is correct
    const match = await bcrypt.compare(String(currentPassword), user.password);
    if (!match) {
      return res.status(401).json({ error: 'Invalid current password' });
    }

    // Prepare the update query and values
    let query = 'UPDATE Users SET ';
    const fields = [];
    const values = [];

    if (email) {
      fields.push('email = ?');
      values.push(email);
    }

    if (newPassword) {
      const hashedPassword = await bcrypt.hash(String(newPassword), 10);
      fields.push('password = ?');
      values.push(hashedPassword);
    }

    if (profilePicture) {
      fields.push('user_image = ?');
      values.push(profilePicture);
    }

    if (phone) {
      fields.push('phone = ?');
      values.push(phone);
    }

    if (fields.length === 0) {
      return res.status(400).json({ error: 'No fields to update' });
    }

    query += fields.join(', ') + ' WHERE id = ?';
    values.push(id);

    // Execute the update query
    await queryAsync(query, values);

    res.status(200).json({ message: 'User updated successfully' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

/**
 * Controller function to get all users.
 */
const getUsers = async (req, res) => {
  try {
    const users = await queryAsync('SELECT id, name, email, username FROM Users');
    res.status(200).json(users);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

/**
 * Controller function to get a user by ID.
 */
const getUserById = async (req, res) => {
  try {
    const { id } = req.params;
    const userResults = await queryAsync('SELECT id, name, email, username FROM Users WHERE id = ?', [id]);

    if (userResults.length > 0) {
      res.status(200).json(userResults[0]);
    } else {
      res.status(404).json({ error: 'User not found' });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

/**
 * Controller function to get all products from a user.
 */
const getProductsFromUser = async (req, res) => {
  try {
    const { id } = req.params;

    // Fetch products from the specified user with associated categories, SKU, slug, and seller verification status
    const products = await queryAsync(`
      SELECT 
        p.*, 
        (SELECT verified FROM Users WHERE id = p.seller_id) AS is_seller_verified,
        GROUP_CONCAT(CONCAT('{ "categoryName": "', c.name, '", "category_id": ', pc.category_id, '}')) AS categories
      FROM 
        Products p
      LEFT JOIN
        Product_Categories pc ON p.id = pc.product_id
      LEFT JOIN
        Categories c ON pc.category_id = c.id
      WHERE
        p.seller_id = ?
      GROUP BY
        p.id
    `, [id]);

    // Parse categories for each product
    products.forEach(product => {
      product.categories = JSON.parse(`[${product.categories}]`);
    });

    // Fetch and add images for each product
    for (let product of products) {
      const productImages = await queryAsync('SELECT id, image_link FROM Product_Images WHERE product_id = ?', [product.id]);
      product.images = productImages.map(image => ({
        ...image,
        imageUrl: `http://localhost:${process.env.PORT}/uploads/products/${image.image_link}`
      }));
    }

    res.json(products);
  } catch (error) {
    console.error('Error fetching products:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

/**
 * Controller function to get all detailed information about a user.
 */
const getAllInfoFromUser = async (req, res) => {
  try {
    const { id } = req.params;

    // Fetch user information
    const userResults = await queryAsync('SELECT * FROM Users WHERE id = ?', [id]);

    if (userResults.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    const user = userResults[0];

    // Fetch user addresses
    const addressesResults = await queryAsync(`
      SELECT ua.title, ua.main_address, a.street, a.city, a.state, a.postal_code, a.country, a.number
      FROM User_Addresses ua
      LEFT JOIN Addresses a ON ua.address_id = a.id
      WHERE ua.user_id = ?
    `, [id]);

    const addresses = addressesResults.map(address => ({
      title: address.title,
      street: address.street,
      city: address.city,
      state: address.state,
      postalCode: address.postal_code,
      country: address.country,
      number: address.number,
      isMainAddress: address.main_address === 1
    }));

    // Fetch all transactions with specified statuses
    const transactionsResults = await queryAsync(`
      SELECT t.id, t.status, t.total_amount, t.created_at,
             GROUP_CONCAT(CONCAT(tsh.old_status, ' -> ', tsh.new_status, ' at ', tsh.changed_at) ORDER BY tsh.changed_at DESC SEPARATOR '; ') AS status_history
      FROM Transactions t
      LEFT JOIN Transaction_Status_History tsh ON t.id = tsh.transaction_id
      WHERE t.seller_id = ? AND t.status IN ('Aguardando Pagamento', 'Pagamento Recebido', 'Processando', 'Enviado', 'Entregue', 'Concluído', 'Cancelado')
      GROUP BY t.id
    `, [id]);

    // Calculate total sales and total sales value
    let totalSales = 0;
    let totalSalesValue = 0;

    transactionsResults.forEach(transaction => {
      if (transaction.status !== 'Cancelado') {
        totalSales++;
        totalSalesValue += transaction.total_amount;
      }
    });

    // Fetch wallet information
    const walletResults = await queryAsync('SELECT * FROM Wallets WHERE user_id = ?', [id]);
    const wallet = walletResults.length > 0 ? walletResults[0] : null;

    // Calculate mean rating of the seller
    const meanRatingResult = await queryAsync('SELECT AVG(rating) AS meanRating FROM Reviews WHERE seller_id = ?', [id]);
    const meanRating = meanRatingResult[0].meanRating || 0;

    // Fetch reviews with user names and pictures
    const reviewsResults = await queryAsync(`
      SELECT r.rating, r.comment, r.created_at, u.id AS userId, u.name AS userName, u.user_image AS userImage
      FROM Reviews r
      INNER JOIN Users u ON r.user_id = u.id
      WHERE r.seller_id = ?
    `, [id]);

    const reviews = reviewsResults.map(review => ({
      userId: review.userId,
      userName: review.userName,
      userImage: review.userImage ? `http://localhost:${process.env.PORT}/uploads/users/${review.userImage}` : null,
      rating: review.rating,
      comment: review.comment,
      createdAt: review.created_at
    }));

    const transactions = transactionsResults.map(transaction => {
      let statusHistory = [];
      if (transaction.status_history) {
        statusHistory = transaction.status_history.split('; ').map(entry => {
          const [statusChange, changedAt] = entry.split(' at ');
          const [oldStatus, newStatus] = statusChange.split(' -> ');
          return {
            newStatus: newStatus.trim(),
            oldStatus: oldStatus.trim(),
            changedAt: new Date(changedAt.trim()).toISOString()
          };
        });
      }

      return {
        id: transaction.id,
        status: transaction.status,
        totalAmount: transaction.total_amount,
        createdAt: transaction.created_at,
        statusHistory
      };
    });

    // Fetch product-related information
    const announcedProductsResult = await queryAsync('SELECT COUNT(*) as announcedProducts FROM Products WHERE seller_id = ?', [id]);
    const announcedProducts = announcedProductsResult[0].announcedProducts;

    const availableProductsResult = await queryAsync('SELECT COUNT(*) as availableProducts FROM Products WHERE seller_id = ? AND available = 1', [id]);
    const availableProducts = availableProductsResult[0].availableProducts;

    const soldProductsResult = await queryAsync('SELECT COUNT(*) as soldProducts FROM Transactions WHERE seller_id = ? AND status = "Concluído"', [id]);
    const soldProducts = soldProductsResult[0].soldProducts;

    // Construct user info object
    const userInfo = {
      id: user.id,
      name: user.name,
      email: user.email,
      username: user.username,
      profilePicture: user.user_image ? `http://localhost:${process.env.PORT}/uploads/users/${user.user_image}` : null,
      phone: user.phone,
      userType: user.user_type,
      verified: user.verified,
      createdAt: user.created_at,
      addresses,
      totalSales,
      totalSalesValue,
      wallet,
      meanRating,
      reviews,
      announcedProducts,
      availableProducts,
      soldProducts,
      transactions
    };

    res.status(200).json(userInfo);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

const getOrdersByUserId = async (req, res) => {
  const userId = parseInt(req.params.id, 10);

  if (isNaN(userId)) {
      return res.status(STATUS_CODES.BAD_REQUEST).json({ error: ERRORS.BAD_REQUEST });
  }

  try {
      const orders = await queryAsync(`
          SELECT 
              t.id AS transaction_id,
              t.buyer_id,
              t.seller_id,
              t.product_id,
              t.quantity,
              t.total_amount,
              t.transaction_type,
              t.payment_method,
              t.shipping_method,
              t.status,
              t.created_at,
              p.name AS product_name,
              (SELECT JSON_OBJECT('id', ua.id, 'city', a.city, 'state', a.state, 'street', a.street, 'number', a.number) 
               FROM user_addresses ua 
               JOIN addresses a ON ua.address_id = a.id 
               WHERE ua.user_id = t.buyer_id AND ua.main_address = 1) AS buyer_address,
              (SELECT JSON_OBJECT('id', ua.id, 'city', a.city, 'state', a.state, 'street', a.street, 'number', a.number) 
               FROM user_addresses ua 
               JOIN addresses a ON ua.address_id = a.id 
               WHERE ua.user_id = t.seller_id AND ua.main_address = 1) AS seller_address
          FROM transactions t
          JOIN products p ON t.product_id = p.id
          WHERE t.buyer_id = ?
      `, [userId]);

      const parsedOrders = orders.map(order => ({
          ...order,
          buyer_address: JSON.parse(order.buyer_address),
          seller_address: JSON.parse(order.seller_address)
      }));

      res.json(parsedOrders);
  } catch (error) {
      console.error('Error fetching orders:', error);
      res.status(STATUS_CODES.INTERNAL_SERVER_ERROR).json({ error: ERRORS.INTERNAL_SERVER_ERROR });
  }
};

module.exports = { register, login, getUsers, getUserById, getProductsFromUser, getAllInfoFromUser, updateUser, getOrdersByUserId };
