// Import necessary modules and controllers
const express = require('express');
const { createProduct, getProductById, getProducts, updateProductById, deleteProductById } = require('../controllers/productController');
const { verifyToken } =  require('../middleware/authentication');
const { handleMultipleImageUpload } = require('../middleware/uploadsMiddleware');

// Create a router instance
const router = express.Router();

router.post('/', verifyToken, handleMultipleImageUpload, createProduct);
router.get('/', getProducts);
router.get('/:id', getProductById); 
router.patch('/:id', verifyToken, updateProductById);
router.delete('/:id', verifyToken, deleteProductById);

// Export the router
module.exports = router;
