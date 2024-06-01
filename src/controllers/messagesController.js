const { queryAsync } = require('../db');
const io = require('../app'); // Importe o io do app.js

const createMessage = async (req, res) => {
    const { receiver_id, content, is_read } = req.body;
    const sender_id = req.userId; // Access userId from the request object

    try {
        if (!sender_id || !receiver_id || !content || typeof is_read !== 'boolean') {
            return res.status(400).json({ error: 'Invalid message data provided' });
        }

        const result = await queryAsync('INSERT INTO messages (sender_id, receiver_id, content, is_read) VALUES (?, ?, ?, ?)', [sender_id, receiver_id, content, is_read]);
        const newMessage = {
            id: result.insertId,
            sender_id,
            receiver_id,
            content,
            is_read,
            timestamp: new Date()
        };

        // Emitir a mensagem para o destinatário
        io.to(receiver_id.toString()).emit('newMessage', newMessage);

        res.status(201).json({ message: 'Message created successfully', id: result.insertId });
    } catch (error) {
        console.error('Error creating message:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const getMessagesBetweenUsers = async (req, res) => {
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

module.exports = { createMessage, getMessagesBetweenUsers };
