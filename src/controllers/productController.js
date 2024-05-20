const { queryAsync } = require('../db');

// Interface to represent a product
const getProducts = async (req, res) => {
    try {
        // Fetch all products with their associated categories
        const products = await queryAsync(`
            SELECT 
                p.*, 
                GROUP_CONCAT(CONCAT('{ "categoryName": "', c.name, '", "category_id": ', pc.category_id, '}')) AS categories
            FROM 
                products p
            LEFT JOIN
                product_categories pc ON p.id = pc.product_id
            LEFT JOIN
                categories c ON pc.category_id = c.id
            GROUP BY
                p.id
        `);
        
        // Parse categories for each product
        products.forEach(product => {
            product.categories = JSON.parse(`[${product.categories}]`);
        });

        res.json(products);
    } catch (error) {
        console.error('Error fetching products:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

// Controller to get a product by ID
const getProductById = async (req, res) => {
    const productId = parseInt(req.params.id);
    try {
        // Fetch product details along with associated categories
        const product = await queryAsync(`
            SELECT 
                p.*, 
                GROUP_CONCAT(CONCAT('{ "categoryName": "', c.name, '", "category_id": ', pc.category_id, '}')) AS categories
            FROM 
                products p
            LEFT JOIN
                product_categories pc ON p.id = pc.product_id
            LEFT JOIN
                categories c ON pc.category_id = c.id
            WHERE 
                p.id = ?
            GROUP BY
                p.id
        `, [productId]);

        if (product.length === 0) {
            return res.status(404).json({ error: 'Product not found' });
        }

        // Fetch images associated with the product
        const productImages = await queryAsync('SELECT id, image_link FROM product_images WHERE product_id = ?', [productId]);

        // Add full image paths to the product images
        const fullProductImages = productImages.map(image => ({
            ...image,
            imageUrl: `http://localhost:3001/uploads/products/${image.image_link}`
        }));

        // Add images with full paths and categories to the product object
        const productWithFullDetails = {
            ...product[0],
            images: fullProductImages,
            categories: JSON.parse(`[${product[0].categories}]`)
        };

        res.json(productWithFullDetails);
    } catch (error) {
        console.error('Error fetching product:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

// Controller to create a new product
const createProduct = async (req, res) => {
    const { seller_id, name, description, category_ids, brand, model, product_condition, price, available } = req.body;
    try {
        // Check if the seller is verified
        const [{ verified }] = await queryAsync('SELECT verified FROM users WHERE id = ?', [seller_id]);
        
        if (verified === undefined) {
            return res.status(404).json({ error: 'User not found or verification status not available' });
        }

        // Parse category_ids string into an array of integers
        const parsedCategoryIds = JSON.parse(category_ids);

        // Insert product details into the products table along with seller verification status
        const result = await queryAsync('INSERT INTO products (seller_id, name, description, brand, model, product_condition, price, available, is_seller_verified) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', [seller_id, name, description, brand, model, product_condition, price, available, verified]);
        
        const productId = result.insertId;

        // Insert product categories into the product_categories table
        if (parsedCategoryIds && Array.isArray(parsedCategoryIds)) {
            // Ensure only unique categories are inserted
            const uniqueCategoryIds = Array.from(new Set(parsedCategoryIds));
            const categoryInsertPromises = uniqueCategoryIds.map(async (categoryId) => {
                await queryAsync('INSERT INTO product_categories (product_id, category_id) VALUES (?, ?)', [productId, categoryId]);
            });
            await Promise.all(categoryInsertPromises);
        }

        // Insert image links into the product_images table using the middleware
        if (req.body.imagePaths && req.body.imagePaths.length > 0) {
            const imageInsertPromises = req.body.imagePaths.map(async (imageLink) => {
                await queryAsync('INSERT INTO product_images (product_id, image_link) VALUES (?, ?)', [productId, imageLink]);
            });
            await Promise.all(imageInsertPromises);
        }

        res.status(201).json({ message: 'Product created successfully', id: productId });
    } catch (error) {
        console.error('Error creating product:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};
// Controller to update a product by ID using PATCH
const updateProductById = async (req, res) => {
    const productId = parseInt(req.params.id);
    const updates = req.body;
    try {
        // Extract category_ids if present in the updates
        const { category_ids, ...productUpdates } = updates;

        // Check if category_ids are present
        if (!category_ids && !Object.keys(productUpdates).length > 0) {
            return res.status(400).json({ error: 'No update data provided' });
        }

        // Prepare the SET clause for the SQL query for productUpdates
        let setClause = '';
        const updateParams = [];
        Object.entries(productUpdates).forEach(([key, value]) => {
            setClause += `${key} = ?, `;
            updateParams.push(value);
        });

        // Update product details only if there are updates
        if (setClause) {
            // Construct the SQL query for productUpdates
            let updateQuery = 'UPDATE products SET ';
            // Remove the trailing comma and space
            setClause = setClause.slice(0, -2);
            updateQuery += `${setClause} WHERE id = ?`;
            // Add productId to updateParams
            updateParams.push(productId);
            // Execute the update query
            await queryAsync(updateQuery, updateParams);
        }

        // Update product categories if category_ids are present
        if (category_ids && category_ids.length > 0) {
            // Delete existing associations
            await queryAsync('DELETE FROM product_categories WHERE product_id = ?', [productId]);
            // Insert new associations
            const categoryInsertPromises = category_ids.map(async (categoryId) => {
                await queryAsync('INSERT INTO product_categories (product_id, category_id) VALUES (?, ?)', [productId, categoryId]);
            });
            await Promise.all(categoryInsertPromises);
        }

        res.json({ message: 'Product updated successfully' });
    } catch (error) {
        console.error('Error updating product:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

// Controller to delete a product by ID
const deleteProductById = async (req, res) => {
    const productId = parseInt(req.params.id);
    try {
        // Delete associated records in product_categories table
        await queryAsync('DELETE FROM product_categories WHERE product_id = ?', [productId]);
        
        // Delete associated records in product_images table
        await queryAsync('DELETE FROM product_images WHERE product_id = ?', [productId]);

        // Delete the product itself
        const result = await queryAsync('DELETE FROM products WHERE id = ?', [productId]);
        
        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Product not found' });
        }
        res.json({ message: 'Product deleted successfully' });
    } catch (error) {
        console.error('Error deleting product:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

module.exports = { getProducts, getProductById, createProduct, updateProductById, deleteProductById };
