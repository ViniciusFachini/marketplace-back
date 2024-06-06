// controller file

const { queryAsync } = require('../db');
const { getIO } = require('../service/chat')

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
    const { sender_id, receiver_id } = req.params;

    if (!sender_id || !receiver_id) {
        return res.status(400).json({ error: 'Sender ID and receiver ID are required' });
    }

    try {
        // Fetching messages between sender and receiver with sender's name and profile picture
        const messages = await queryAsync(
            `SELECT 
                m.*, 
                u.name AS sender_name, 
                u.user_image AS sender_profile_picture 
            FROM 
                messages m 
                JOIN users u ON m.sender_id = u.id 
            WHERE 
                (m.sender_id = ? AND m.receiver_id = ?) 
                OR (m.sender_id = ? AND m.receiver_id = ?)`,
            [sender_id, receiver_id, sender_id, receiver_id]
        );
        res.json(messages);
    } catch (error) {
        console.error('Error fetching messages between persons:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const getLastChats = async (req, res) => {
    const user_id = req.userId;
    console.log(user_id);
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

            // Get chat partner details
            const chatPartnerDetails = await queryAsync(
                'SELECT id, name, user_image FROM users WHERE id = ?',
                [chat_partner_id]
            );

            if (chatPartnerDetails.length === 0) {
                console.log(`No details found for chat partner with id ${chat_partner_id}`);
                continue; // Skip if no details found for the chat partner
            }

            const chat_partner = chatPartnerDetails[0];

            // Get the last unread message from the chat
            const unreadMessagesCount = await queryAsync(
                'SELECT COUNT(*) AS unreadCount FROM messages WHERE (sender_id = ? AND receiver_id = ?) AND is_read = false',
                [chat_partner_id, user_id]
            );


            // If there are no unread messages, get the last message from the chat
            const lastMessage = await queryAsync(
                'SELECT * FROM messages WHERE (sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?) ORDER BY timestamp DESC LIMIT 1',
                [chat_partner_id, user_id, user_id, chat_partner_id]
            );

            if (lastMessage.length > 0) {
                chats.push({
                    chat_partner: {
                        chat_partner_id: chat_partner.id,
                        chat_partner_name: chat_partner.name,
                        chat_partner_profile_picture: chat_partner.user_image
                    },
                    messages: {
                        lastMessage: lastMessage[0],
                        unreadMessages: unreadMessagesCount[0].unreadCount
                    }
                });
            }
        }

        res.json(chats);
    } catch (error) {
        console.error('Error fetching last chats:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

module.exports = { createMessage, getMessagesBetweenUsers, getLastChats, getUnreadMessagesCount };
