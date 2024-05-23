const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { queryAsync } = require('../db');

/**
 * Controller function for user registration.
 */
const register = async (req, res) => {
  try {
    const { name, email, password, username, phone, user_type } = req.body;

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

    const userResult = await queryAsync(userQuery, userValues);

    const userId = userResult.insertId;

    // Address handling (optional)
    if (req.body.address) {
      const { street, city, state, postal_code, country, title } = req.body.address;

      const addressQuery = 'INSERT INTO Addresses (street, city, state, postal_code, country) VALUES (?, ?, ?, ?, ?)';
      const addressValues = [street, city, state, postal_code, country];

      const addressResult = await queryAsync(addressQuery, addressValues);

      const addressId = addressResult.insertId;

      const userAddressQuery = 'INSERT INTO User_Addresses (user_id, address_id, title) VALUES (?, ?, ?)';
      const userAddressValues = [userId, addressId, title];

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

    const userResults = await queryAsync('SELECT * FROM Users WHERE id = ?', [id]);

    if (userResults.length > 0) {
      const user = userResults[0];

      const detailedUserResults = await queryAsync(`
        SELECT u.id, u.name, u.email, u.username, u.user_image, u.phone, u.user_type, u.verified, u.created_at,
        ua.title, ua.main_address, a.street, a.city, a.state, a.postal_code, a.country
        FROM Users u
        LEFT JOIN User_Addresses ua ON u.id = ua.user_id
        LEFT JOIN Addresses a ON ua.address_id = a.id
        WHERE u.id = ?
      `, [user.id]);

      const userData = {
        id: user.id,
        name: user.name,
        email: user.email,
        username: user.username,
        profilePicture: user.user_image ? `http://localhost:${process.env.PORT}/uploads/users/${user.user_image}` : null,
        phone: user.phone,
        userType: user.user_type,
        verified: user.verified,
        createdAt: user.created_at,
        addresses: {}
      };

      // Categorize addresses into main, address_1, address_2, etc.
      detailedUserResults.forEach((address, index) => {
        const addressCategory = address.main_address ? 'main' : `address_${index + 1}`;
        userData.addresses[addressCategory] = {
          title: address.title,
          street: address.street,
          city: address.city,
          state: address.state,
          postalCode: address.postal_code,
          country: address.country
        };
      });

      const transactionsResults = await queryAsync('SELECT status, total_amount FROM Transactions WHERE seller_id = ?', [user.id]);
      const totalSales = transactionsResults.length;
      const canceledSales = transactionsResults.filter(transaction => transaction.status === 'Cancelado').length;
      const totalSalesValue = transactionsResults.reduce((sum, transaction) => sum + transaction.total_amount, 0);
      const lastTransactionsResults = await queryAsync('SELECT * FROM Transactions WHERE seller_id = ? ORDER BY created_at DESC LIMIT 5', [user.id]);

      // Count announced products
      const announcedProductsResult = await queryAsync('SELECT COUNT(*) as announcedProducts FROM Products WHERE seller_id = ?', [user.id]);
      const announcedProducts = announcedProductsResult[0].announcedProducts;

      // Count available products
      const availableProductsResult = await queryAsync('SELECT COUNT(*) as availableProducts FROM Products WHERE seller_id = ? AND available = 1', [user.id]);
      const availableProducts = availableProductsResult[0].availableProducts;

      userData.totalSales = totalSales;
      userData.canceledSales = canceledSales;
      userData.totalSalesValue = totalSalesValue;
      userData.lastTransactions = lastTransactionsResults;
      userData.announcedProducts = announcedProducts;
      userData.availableProducts = availableProducts;

      res.status(200).json(userData);
    } else {
      res.status(404).json({ error: 'User not found' });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

module.exports = { register, login, getUsers, getUserById, getProductsFromUser, getAllInfoFromUser, updateUser };
