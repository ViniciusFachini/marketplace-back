const { Request, Response } = require('express');
const { queryAsync } = require('../db'); // Adjust the path as necessary

const getMessages = async (req, res) => {
    try {
        const messages = await queryAsync('SELECT * FROM messages');
        res.json(messages);
    } catch (error) {
        console.error('Error fetching messages:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const getMessageById = async (req, res) => {
    const messageId = parseInt(req.params.id);
    try {
        const message = await queryAsync('SELECT * FROM messages WHERE id = ?', [messageId]);
        if (message.length === 0) {
            return res.status(404).json({ error: 'Message not found' });
        }
        res.json(message[0]);
    } catch (error) {
        console.error('Error fetching message:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const createMessage = async (req, res) => {
    const { receiver_id, content, is_read } = req.body;
    const sender_id = req.userId; // Access userId from the request object

    try {
        if (!sender_id || !receiver_id || !content || typeof is_read !== 'boolean') {
            return res.status(400).json({ error: 'Invalid message data provided' });
        }

        const result = await queryAsync('INSERT INTO messages (sender_id, receiver_id, content, is_read) VALUES (?, ?, ?, ?)', [sender_id, receiver_id, content, is_read]);
        res.status(201).json({ message: 'Message created successfully', id: result.insertId });
    } catch (error) {
        console.error('Error creating message:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const updateMessageById = async (req, res) => {
    const messageId = parseInt(req.params.id);
    const updates = req.body;
    try {
        let updateQuery = 'UPDATE messages SET ';
        const updateParams = [];
        Object.entries(updates).forEach(([key, value], index, array) => {
            updateQuery += `${key} = ?, `;
            updateParams.push(value);
        });
        if (updateParams.length === 0) {
            return res.status(400).json({ error: 'No update data provided' });
        }
        updateQuery = updateQuery.slice(0, -2);
        updateQuery += ' WHERE id = ?';
        updateParams.push(messageId);
        const result = await queryAsync(updateQuery, updateParams);
        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Message not found' });
        }
        res.json({ message: 'Message updated successfully' });
    } catch (error) {
        console.error('Error updating message:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const deleteMessageById = async (req, res) => {
    const messageId = parseInt(req.params.id);
    try {
        const result = await queryAsync('DELETE FROM messages WHERE id = ?', [messageId]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Message not found' });
        }
        res.json({ message: 'Message deleted successfully' });
    } catch (error) {
        console.error('Error deleting message:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const getMessagesBetweenPersons = async (req, res) => {
    const { sender_id, receiver_id } = req.body;
    
    if (!sender_id || !receiver_id) {
        return res.status(400).json({ error: 'Sender ID and receiver ID are required' });
    }

    try {
        const messages = await queryAsync('SELECT * FROM messages WHERE (sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)', [sender_id, receiver_id, receiver_id, sender_id]);
        res.json(messages);
    } catch (error) {
        console.error('Error fetching messages between persons:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

module.exports = {getMessageById, getMessages, createMessage, deleteMessageById, updateMessageById, getMessagesBetweenPersons}