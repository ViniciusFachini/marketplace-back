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

    const results = await queryAsync('SELECT * FROM Users WHERE email = ?', [email]);

    if (results.length > 0) {
      const match = await bcrypt.compare(String(password), results[0].password);

      if (match) {
        const expirationTime = 3600; // 1 hour in seconds
        const token = jwt.sign(
          { username: results[0].username, id: results[0].id },
          process.env.JWT_SECRET,
          { expiresIn: expirationTime }
        );

        const userData = {
          email: results[0].email,
          username: results[0].username,
          profilePicture: results[0].user_image,
          userType: results[0].user_type
        };

        res.status(200).json({ token, userData, expiresIn: expirationTime });
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
