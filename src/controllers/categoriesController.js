const { Request, Response } = require('express');
const { queryAsync } = require('../db'); // Adjust the path as necessary

// Controller to get all categories
const getCategories = async (req, res) => {
    try {
        // Fetch all categories
        const categories = await queryAsync('SELECT * FROM categories');

        // Fetch all children for each category
        for (let category of categories) {
            const children = await queryAsync('SELECT * FROM categories WHERE parent_category_id = ?', [category.id]);
            category.children = children;
        }

        // Response
        res.json(categories);
    } catch (error) {
        console.error('Error fetching categories:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const getChildCategoriesByParentId = async (req, res) => {
    const parentId = req.params.parentId; // Assuming parent ID is passed in the URL params
    try {
        const childCategories = await queryAsync('SELECT * FROM categories WHERE parent_category_id = ?', [parentId]);
        res.json(childCategories);
    } catch (error) {
        console.error('Error fetching child categories:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

// Controller to get a category by ID
const getCategoryById = async (req, res) => {
    const categoryId = parseInt(req.params.id);
    try {
        const category = await queryAsync('SELECT * FROM categories WHERE id = ?', [categoryId]);
        if (category.length === 0) {
            return res.status(404).json({ error: 'Category not found' });
        }
        res.json(category[0]);
    } catch (error) {
        console.error('Error fetching category:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

// Controller to create a new category
const createCategory = async (req, res) => {
    const { name, description, parent_category_id } = req.body;
    try {
        const result = await queryAsync('INSERT INTO categories (name, description, parent_category_id) VALUES (?, ?, ?)', [name, description, parent_category_id]);
        res.status(201).json({ message: 'Category created successfully', id: result.insertId });
    } catch (error) {
        console.error('Error creating category:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

// Controller to update a category by ID using PATCH
const updateCategoryById = async (req, res) => {
    const categoryId = parseInt(req.params.id);
    const updates = req.body;
    try {
        let updateQuery = 'UPDATE categories SET ';
        const updateParams = [];
        Object.entries(updates).forEach(([key, value], index, array) => {
            updateQuery += `${key} = ?, `;
            updateParams.push(value);
        });
        if (updateParams.length === 0) {
            return res.status(400).json({ error: 'No update data provided' });
        }
        // Removing the trailing comma and space
        updateQuery = updateQuery.slice(0, -2);

        updateQuery += ' WHERE id = ?';
        updateParams.push(categoryId);

        const result = await queryAsync(updateQuery, updateParams);

        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Category not found' });
        }
        res.json({ message: 'Category updated successfully' });
    } catch (error) {
        console.error('Error updating category:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

// Controller to delete a category by ID
const deleteCategoryById = async (req, res) => {
    const categoryId = parseInt(req.params.id);
    try {
        const result = await queryAsync('DELETE FROM categories WHERE id = ?', [categoryId]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Category not found' });
        }
        res.json({ message: 'Category deleted successfully' });
    } catch (error) {
        console.error('Error deleting category:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

// Controller to get products by category ID
const getProductsByCategoryId = async (req, res) => {
    const categoryId = parseInt(req.params.id);
    try {
        // Fetch products for the given category ID
        const products = await queryAsync('SELECT * FROM products WHERE category_id = ?', [categoryId]);

        // Loop through each product to fetch associated images
        for (let i = 0; i < products.length; i++) {
            const productId = products[i].id;
            // Fetch images associated with the product
            const productImages = await queryAsync('SELECT id, image_link FROM product_images WHERE product_id = ?', [productId]);

            // Add full image URLs to the product images
            const fullProductImages = productImages.map(image => ({
                ...image,
                imageUrl: `http://localhost:${process.env.PORT}/uploads/products/${image.image_link}`
            }));

            // Assign the array of images with full URLs to the product object
            products[i].images = fullProductImages;
        }

        res.json(products);
    } catch (error) {
        console.error('Error fetching products by category:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};



module.exports = {getCategories, getChildCategoriesByParentId, getCategoryById, createCategory, updateCategoryById, deleteCategoryById, getProductsByCategoryId}
