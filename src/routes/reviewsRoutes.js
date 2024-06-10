const express = require('express');
const {
    getReviews, getReviewById, createReview
} = require('../controllers/reviewsController');

const { verifyToken, getUserIdFromToken } = require('../middleware/authentication')

const router = express.Router();

router.get('/', getReviews);
router.get('/:id', getReviewById);
router.post('/', verifyToken, getUserIdFromToken, createReview);

module.exports = router;
