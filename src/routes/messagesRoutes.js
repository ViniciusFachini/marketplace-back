const express = require('express');
const {
  getMessagesBetweenUsers,
  createMessage
} = require('../controllers/messagesController');
const { verifyToken, getUserIdFromToken } = require('../middleware/authentication');

const router = express.Router();

router.get('/:sender/:receiver', verifyToken, getMessagesBetweenUsers);
router.post('/', verifyToken, getUserIdFromToken, createMessage);

module.exports = router;
