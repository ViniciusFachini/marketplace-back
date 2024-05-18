const { queryAsync } = require('../db');

// Interface to represent a product
const getProducts = async (req, res) => {
    try {
        // Fetch all products
        const products = await queryAsync('SELECT * FROM products');
        
        // Loop through each product to fetch associated images
        for (let i = 0; i < products.length; i++) {
            const productId = products[i].id;
            // Fetch images associated with the product
            const productImages = await queryAsync('SELECT image_link FROM product_images WHERE product_id = ?', [productId]);
            
            // Add full image paths to the product images
            const fullProductImages = productImages.map(image => ({
                ...image,
                imageUrl: `http://localhost:3001/uploads/products/${image.image_link}`
            }));
            
            // Assign the array of images with full paths to the product object
            products[i].images = fullProductImages;
        }
        
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
        // Fetch product details
        const product = await queryAsync('SELECT id, image_link FROM products WHERE id = ?', [productId]);
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

        // Add images with full paths to the product object
        const productWithFullImages = {
            ...product[0],
            images: fullProductImages
        };

        res.json(productWithFullImages);
    } catch (error) {
        console.error('Error fetching product:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

// Controller to create a new product
// Controller to create a new product
// Controller to create a new product
const createProduct = async (req, res) => {
    const { seller_id, name, description, category_id, brand, model, product_condition, price, available } = req.body;
    try {
        // Check if the seller is verified
        const [{ verified }] = await queryAsync('SELECT verified FROM users WHERE id = ?', [seller_id]);
        
        if (verified === undefined) {
            return res.status(404).json({ error: 'User not found or verification status not available' });
        }

        // Insert product details into the products table along with seller verification status
        const result = await queryAsync('INSERT INTO products (seller_id, name, description, category_id, brand, model, product_condition, price, available, is_seller_verified) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', [seller_id, name, description, category_id, brand, model, product_condition, price, available, verified]);
        
        const productId = result.insertId;

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
        let updateQuery = 'UPDATE products SET ';
        const updateParams = [];
        Object.entries(updates).forEach(([key, value]) => {
            updateQuery += `${key} = ?, `;
            updateParams.push(value);
        });
        if (updateParams.length === 0) {
            return res.status(400).json({ error: 'No update data provided' });
        }
        // Removing the trailing comma and space
        updateQuery = updateQuery.slice(0, -2);

        updateQuery += ' WHERE id = ?';
        updateParams.push(productId);

        const result = await queryAsync(updateQuery, updateParams);

        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Product not found' });
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
