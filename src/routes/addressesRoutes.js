const express = require('express');
const {
  getAddresses,
  getAddressById,
  updateAddressById,
  linkUserToAddress,
  createAddress,
  deleteAddressById,
  createAndLinkAddress
} = require('../controllers/addressesController');
const { verifyToken } = require('../middleware/authentication');

const router = express.Router();

router.get('/', verifyToken, getAddresses);
router.get('/:id', verifyToken, getAddressById);
router.patch('/:id', verifyToken, updateAddressById);
router.patch('/', verifyToken, linkUserToAddress);
router.post('/', verifyToken, createAddress);
router.post('/create-and-link', verifyToken, createAndLinkAddress);
router.delete('/:id', verifyToken, deleteAddressById);

module.exports = router;
