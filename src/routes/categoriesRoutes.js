const express = require('express');
const {
  getCategories,
  getCategoryById,
  getProductsByCategoryId,
  createCategory,
  updateCategoryById,
  deleteCategoryById,
  getChildCategoriesByParentId
} = require('../controllers/categoriesController');
const { authorize } = require('../middleware/authorization');
const {verifyToken} = require('../middleware/authentication')

const router = express.Router();

router.get('/', getCategories);
router.get('/:id', getCategoryById);
router.get('/:parentId/children', getChildCategoriesByParentId)
router.get('/:id/products', getProductsByCategoryId);
router.post('/', verifyToken, authorize, createCategory);
router.patch('/:id', verifyToken, authorize, updateCategoryById);
router.delete('/:id', verifyToken, authorize, deleteCategoryById);

module.exports = router;
