const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { queryAsync } = require('../db');

/**
 * Controller function for user registration.
 */
const register = async (req, res) => {
  try {
    const { name, email, password, username, profilePicture, phone, user_type, address_id } = req.body;

    const userExists = await queryAsync('SELECT * FROM Users WHERE username = ?', [username]);
    const emailExists = await queryAsync('SELECT * FROM Users WHERE email = ?', [email]);

    if (userExists.length > 0) {
      return res.status(400).json({ error: 'Username already in use' });
    }

    if (emailExists.length > 0) {
      return res.status(400).json({ error: 'Email already in use' });
    }

    const hashedPassword = await bcrypt.hash(String(password), 10);

    let query = 'INSERT INTO users';
    let fields = '';
    let placeholders = '';
    const values = [];

    if (name !== undefined) {
      fields += 'name, ';
      placeholders += '?, ';
      values.push(name);
    }

    if (email !== undefined) {
      fields += 'email, ';
      placeholders += '?, ';
      values.push(email);
    }

    if (password !== undefined) {
      fields += 'password, ';
      placeholders += '?, ';
      values.push(hashedPassword);
    }

    if (username !== undefined) {
      fields += 'username, ';
      placeholders += '?, ';
      values.push(username);
    }

    if (profilePicture !== undefined) {
      fields += 'user_image, ';
      placeholders += '?, ';
      values.push(profilePicture);
    }

    if (phone !== undefined) {
      fields += 'phone, ';
      placeholders += '?, ';
      values.push(phone);
    }

    if (user_type !== undefined) {
      fields += 'user_type, ';
      placeholders += '?, ';
      values.push(user_type);
    }

    if (address_id !== undefined) {
      fields += 'address_id, ';
      placeholders += '?, ';
      values.push(address_id);
    }

    // Remove the trailing comma and space from fields and placeholders
    fields = fields.slice(0, -2);
    placeholders = placeholders.slice(0, -2);

    query += ` (${fields}) VALUES (${placeholders})`;

    const result = await queryAsync(query, values);

    req.registeredId = result.insertId

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
        const expirationTime = 3600; // 1 hour in seconds
        const token = jwt.sign(
          { username: user.username, id: user.id },
          process.env.JWT_SECRET,
          { expiresIn: expirationTime }
        );

        // Query the users table and join with the addresses table to get the user's information and address details
        const detailedUserResults = await queryAsync(`
          SELECT u.id, u.name, u.email, u.username, u.user_image, u.phone, u.user_type, u.verified, u.created_at,
                 a.street, a.city, a.state, a.postal_code, a.country
          FROM Users u
          JOIN Addresses a ON u.address_id = a.id
          WHERE u.id = ?
        `, [user.id]);

        if (detailedUserResults.length > 0) {
          const detailedUser = detailedUserResults[0];
          const userData = {
            id: detailedUser.id,
            name: detailedUser.name,
            email: detailedUser.email,
            username: detailedUser.username,
            profilePicture: detailedUser.user_image,
            phone: detailedUser.phone,
            userType: detailedUser.user_type,
            verified: detailedUser.verified,
            createdAt: detailedUser.created_at,
            address: {
              street: detailedUser.street,
              city: detailedUser.city,
              state: detailedUser.state,
              postalCode: detailedUser.postal_code,
              country: detailedUser.country
            }
          };

          // Query the transactions table to get the sales, count cancellations, and sum the total value of all sales
          const transactionsResults = await queryAsync('SELECT status, total_amount FROM Transactions WHERE seller_id = ?', [user.id]);

          const totalSales = transactionsResults.length;
          const canceledSales = transactionsResults.filter(transaction => transaction.status === 'Cancelado').length;
          const totalSalesValue = transactionsResults.reduce((sum, transaction) => sum + transaction.total_amount, 0);

          // Query the transactions table to get the last 5 transactions
          const lastTransactionsResults = await queryAsync('SELECT * FROM Transactions WHERE seller_id = ? ORDER BY created_at DESC LIMIT 5', [user.id]);

          // Add sales, total sales value, and last 5 transactions information to user data
          userData.totalSales = totalSales;
          userData.canceledSales = canceledSales;
          userData.totalSalesValue = totalSalesValue;
          userData.lastTransactions = lastTransactionsResults;

          res.status(200).json({ token, userData, expiresIn: expirationTime });
        } else {
          res.status(404).json({ error: 'User not found' });
        }
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

module.exports = { register, login };
