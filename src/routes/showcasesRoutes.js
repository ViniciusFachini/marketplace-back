// Import necessary modules and controllers
const express = require('express');
const { createShowcase, getShowcaseById, getShowcases, updateShowcaseById, deleteShowcaseById, addItemToShowcase, removeItemFromShowcase } = require('../controllers/showcasesController');
const { verifyToken } = require('../middleware/authentication');

// Create a router instance
const router = express.Router();

// Define endpoints
router.post('/', verifyToken, createShowcase);
router.get('/', getShowcases);
router.get('/:id', getShowcaseById);
router.patch('/:id', verifyToken, updateShowcaseById);
router.delete('/:id', verifyToken, deleteShowcaseById);
router.post('/:showcaseId/add', verifyToken, addItemToShowcase);
router.delete('/:showcaseId/remove', verifyToken, removeItemFromShowcase);

// Export the router
module.exports = router;