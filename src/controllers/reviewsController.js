const { queryAsync } = require('../db');

const getReviews = async (req, res) => {
    const { seller_id } = req.query; // Assuming seller_id is provided in query params
    try {
        const reviewsResults = await queryAsync(`
            SELECT r.rating, r.comment, r.title, r.created_at, u.id AS userId, u.name AS userName, u.user_image AS userImage
            FROM Reviews r
            INNER JOIN Users u ON r.user_id = u.id
            WHERE r.seller_id = ?
        `, [seller_id]);
        res.json(reviewsResults);
    } catch (error) {
        console.error('Error fetching reviews:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const createReview = async (req, res) => {
    const { seller_id, title, comment, rating } = req.body;
    const userId = req.userId

    try {
        const result = await queryAsync('INSERT INTO Reviews (seller_id, title, comment, rating, user_id) VALUES (?, ?, ?, ?, ?)', [seller_id, title, comment, rating, userId]);
        res.status(201).json({ message: 'Review created successfully', id: result.insertId });
    } catch (error) {
        console.error('Error creating review:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

// Controller to get a review by ID
const getReviewById = async (req, res) => {
    const { id } = req.params;
    try {
        const reviewResults = await queryAsync(`
            SELECT r.rating, r.comment, r.title, r.created_at, u.id AS userId, u.name AS userName, u.user_image AS userImage
            FROM Reviews r
            INNER JOIN Users u ON r.user_id = u.id
            WHERE r.id = ?
        `, [id]);
        if (reviewResults.length === 0) {
            return res.status(404).json({ error: 'Review not found' });
        }
        res.json(reviewResults[0]);
    } catch (error) {
        console.error('Error fetching review:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

module.exports = { getReviews, getReviewById, createReview };