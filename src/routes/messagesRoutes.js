const express = require('express');
const {
  getMessages,
  getMessagesBetweenPersons,
  getMessageById,
  updateMessageById,
  createMessage,
  deleteMessageById
} = require('../controllers/messagesController');
const { verifyToken, getUserIdFromToken } = require('../middleware/authentication');

const router = express.Router();

router.get('/', verifyToken, getMessages);
router.get('/:sender/:receiver', verifyToken, getMessagesBetweenPersons);
router.get('/:id', verifyToken, getMessageById);
router.patch('/:id', verifyToken, updateMessageById);
router.post('/', verifyToken, getUserIdFromToken, createMessage);
router.delete('/:id', verifyToken, deleteMessageById);

module.exports = router;
