// controller file

const { queryAsync } = require('../db');
const {getIO} = require('../service/chat')

const createMessage = async (req, res) => {
    const { receiver_id, content, is_read } = req.body;
    const sender_id = req.userId;

    try {
        // Validate input data
        if (!sender_id || !receiver_id || !content || typeof is_read !== 'boolean') {
            return res.status(400).json({ error: 'Invalid message data provided' });
        }

        // Ensure the user can't send a message to themselves
        if (sender_id === receiver_id) {
            return res.status(400).json({ error: 'You cannot send a message to yourself' });
        }

        // Insert the new message into the database
        const result = await queryAsync('INSERT INTO messages (sender_id, receiver_id, content, is_read) VALUES (?, ?, ?, ?)', [sender_id, receiver_id, content, is_read]);
        const newMessage = {
            id: result.insertId,
            sender_id,
            receiver_id,
            content,
            is_read,
            timestamp: new Date()
        };

        // Emit the message to the receiver
        const io = getIO();
        io.to(String(receiver_id)).emit('newMessage', newMessage);

        res.status(201).json({ message: 'Message created successfully', id: result.insertId });
    } catch (error) {
        console.error('Error creating message:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const getUnreadMessagesCount = async (req, res) => {
    const user_id = req.userId;

    try {
        const result = await queryAsync('SELECT COUNT(*) AS unreadCount FROM messages WHERE receiver_id = ? AND is_read = false', [user_id]);
        const unreadCount = result[0].unreadCount;

        res.status(200).json({ unreadCount });
    } catch (error) {
        console.error('Error fetching unread messages count:', error);
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

const getLastChats = async (req, res) => {
    const user_id = req.userId;
    console.log(user_id)
    try {
        // Get distinct chat partners
        const chatPartners = await queryAsync(
            'SELECT DISTINCT sender_id AS chat_partner FROM messages WHERE receiver_id = ? ' +
            'UNION ' +
            'SELECT DISTINCT receiver_id AS chat_partner FROM messages WHERE sender_id = ?',
            [user_id, user_id]
        );

        let chats = [];

        for (let partner of chatPartners) {
            const chat_partner_id = partner.chat_partner;

            // Get unread messages from the chat
            const unreadMessages = await queryAsync(
                'SELECT * FROM messages WHERE sender_id = ? AND receiver_id = ? AND is_read = 0 ORDER BY timestamp',
                [chat_partner_id, user_id]
            );

            if (unreadMessages.length > 0) {
                // If there are unread messages, add them to the chats
                chats.push({
                    chat_partner_id,
                    unreadMessages
                });
            } else {
                // If there are no unread messages, get the last message from the chat
                const lastMessage = await queryAsync(
                    'SELECT * FROM messages WHERE (sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?) ORDER BY timestamp DESC LIMIT 1',
                    [chat_partner_id, user_id, user_id, chat_partner_id]
                );

                if (lastMessage.length > 0) {
                    chats.push({
                        chat_partner_id,
                        lastMessage: lastMessage[0]
                    });
                }
            }
        }

        res.json(chats);
    } catch (error) {
        console.error('Error fetching last chats:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

module.exports = { createMessage, getMessagesBetweenUsers, getLastChats, getUnreadMessagesCount };
