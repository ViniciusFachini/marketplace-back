const express = require('express');
const {
  getMessagesBetweenUsers,
  createMessage,
  getLastChats,
  getUnreadMessagesCount,
  markMessageAsRead
} = require('../controllers/messagesController');
const { verifyToken, getUserIdFromToken } = require('../middleware/authentication');

const router = express.Router();

router.get('/:sender_id/:receiver_id', verifyToken, getMessagesBetweenUsers);
router.post('/', verifyToken, getUserIdFromToken, createMessage);
router.patch('/:messageId/read', verifyToken, getUserIdFromToken, markMessageAsRead);
router.get('/last-messages', verifyToken, getUserIdFromToken, getLastChats);
router.get('/unseen-messages', verifyToken, getUserIdFromToken, getUnreadMessagesCount);

module.exports = router;
