const { Request, Response } = require('express');
const { queryAsync } = require('../db');

// Interface to represent an address
const getAddresses = async (req, res) => {
    try {
        const addresses = await queryAsync('SELECT * FROM addresses');
        res.json(addresses);
    } catch (error) {
        console.error('Error fetching addresses:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

// Controller to get an address by ID
const getAddressById = async (req, res) => {
    const addressId = parseInt(req.params.id);
    try {
        const address = await queryAsync('SELECT * FROM addresses WHERE id = ?', [addressId]);
        if (address.length === 0) {
            return res.status(404).json({ error: 'Address not found' });
        }
        res.json(address[0]);
    } catch (error) {
        console.error('Error fetching address:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

// Controller to create a new address
const createAddress = async (req, res) => {
    const { street, neighbourhood, number, city, state, postal_code, country } = req.body;
    try {
        const result = await queryAsync('INSERT INTO addresses (street, neighbourhood, number, city, state, postal_code, country) VALUES (?, ?, ?, ?, ?, ?, ?)', [street, neighbourhood, number, city, state, postal_code, country]);
        res.status(201).json({ message: 'Address created successfully', id: result.insertId });
    } catch (error) {
        console.error('Error creating address:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

// Controller to update an address by ID using PATCH
const updateAddressById = async (req, res) => {
    const addressId = parseInt(req.params.id);
    const updates = req.body;
    try {
        let updateQuery = 'UPDATE addresses SET ';
        const updateParams = [];
        Object.entries(updates).forEach(([key, value]) => {
            updateQuery += `${key} = ?, `;
            updateParams.push(value);
        });
        if (updateParams.length === 0) {
            return res.status(400).json({ error: 'No update data provided' });
        }
        // Removing the trailing comma and space
        updateQuery = updateQuery.slice(0, -2);

        updateQuery += ' WHERE id = ?';
        updateParams.push(addressId);

        const result = await queryAsync(updateQuery, updateParams);

        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Address not found' });
        }
        res.json({ message: 'Address updated successfully' });
    } catch (error) {
        console.error('Error updating address:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

// Controller to delete an address by ID
const deleteAddressById = async (req, res) => {
    const addressId = parseInt(req.params.id);
    try {
        const result = await queryAsync('DELETE FROM addresses WHERE id = ?', [addressId]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Address not found' });
        }
        res.json({ message: 'Address deleted successfully' });
    } catch (error) {
        console.error('Error deleting address:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

// Controller to link a user to an address
const linkUserToAddress = async (req, res) => {
    const { userId, addressId, title } = req.body;
    try {
      // Check if the user exists
      const userExists = await queryAsync('SELECT * FROM users WHERE id = ?', [userId]);
  
      if (userExists.length === 0) {
        return res.status(404).json({ error: 'User not found' });
      }
  
      // Check if the address exists
      const addressExists = await queryAsync('SELECT * FROM addresses WHERE id = ?', [addressId]);
  
      if (addressExists.length === 0) {
        return res.status(404).json({ error: 'Address not found' });
      }
  
      // Insert a new row into the user_addresses table
      await queryAsync('INSERT INTO user_addresses (user_id, address_id, title) VALUES (?, ?, ?)', [userId, addressId, title]);
  
      res.json({ message: 'User linked to address successfully' });
    } catch (error) {
      console.error('Error linking user to address:', error);
      res.status(500).json({ error: 'Internal Server Error' });
    }
  };

module.exports = { getAddresses, getAddressById, createAddress, updateAddressById, deleteAddressById, linkUserToAddress };
