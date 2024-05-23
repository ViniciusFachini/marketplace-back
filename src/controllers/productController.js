const { queryAsync } = require('../db');

// Interface to represent a product
const getProducts = async (req, res) => {
    try {
        // Fetch all products with their associated categories, SKU, slug, and seller verification status
        const products = await queryAsync(`
            SELECT 
                p.*, 
                (SELECT verified FROM users WHERE id = p.seller_id) AS is_seller_verified,
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

        // Fetch and add images for each product
        for (let product of products) {
            const productImages = await queryAsync('SELECT id, image_link FROM product_images WHERE product_id = ?', [product.id]);
            product.images = productImages.map(image => ({
                ...image,
                imageUrl: `http://localhost:${process.env.PORT}/uploads/products/${image.image_link}`
            }));
        }

        res.json(products);
    } catch (error) {
        console.error('Error fetching products:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const getProductById = async (req, res) => {
    const productId = parseInt(req.params.id);
    try {
        // Fetch product details along with associated categories, SKU, slug, and seller verification status
        const product = await queryAsync(`
            SELECT 
                p.*, 
                (SELECT verified FROM users WHERE id = p.seller_id) AS is_seller_verified,
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
            imageUrl: `http://localhost:${process.env.PORT}/uploads/products/${image.image_link}`
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

const getSellerInfo = async (req, res) => {
    try {
        const { productId } = req.params;

        // Query the products table to get the seller ID of the given product
        const productResults = await queryAsync('SELECT seller_id FROM Products WHERE id = ?', [productId]);

        if (productResults.length > 0) {
            const product = productResults[0];
            const sellerId = product.seller_id;

            // Query the users table to get the seller's information and join with the user_addresses table to get the seller's addresses
            const sellerResults = await queryAsync(`
                SELECT u.id, u.name, u.email, u.username, u.user_image, u.phone, u.user_type, 
                    ua.id as address_id, ua.title, ua.main_address, a.street, a.city, a.state, a.postal_code, a.country
                FROM Users u
                LEFT JOIN user_addresses ua ON u.id = ua.user_id
                LEFT JOIN Addresses a ON ua.address_id = a.id
                WHERE u.id = ?
            `, [sellerId]);

            if (sellerResults.length > 0) {
                const sellerData = {
                    id: sellerResults[0].id,
                    name: sellerResults[0].name,
                    email: sellerResults[0].email,
                    username: sellerResults[0].username,
                    profilePicture: sellerResults[0].user_image ? `http://localhost:${process.env.PORT}/uploads/users/${sellerResults[0].user_image}` : null,
                    phone: sellerResults[0].phone,
                    userType: sellerResults[0].user_type,
                    addresses: {}
                };

                // Categorize addresses into main, address_1, address_2, etc.
                sellerResults.forEach((address, index) => {
                    const addressCategory = address.main_address ? 'main' : `address_${index + 1}`;
                    sellerData.addresses[addressCategory] = {
                        title: address.title,
                        street: address.street,
                        city: address.city,
                        state: address.state,
                        postalCode: address.postal_code,
                        country: address.country
                    };
                });

                // Query the transactions table to get the sales, count cancellations, and sum the total value of all sales
                const transactionsResults = await queryAsync('SELECT status, total_amount FROM Transactions WHERE seller_id = ?', [sellerId]);

                const totalSales = transactionsResults.length;
                const canceledSales = transactionsResults.filter(transaction => transaction.status === 'Cancelado').length;
                const totalSalesValue = transactionsResults.reduce((sum, transaction) => sum + transaction.total_amount, 0);

                // Query the transactions table to get the last 5 transactions
                const lastTransactionsResults = await queryAsync('SELECT * FROM Transactions WHERE seller_id = ? ORDER BY created_at DESC LIMIT 5', [sellerId]);

                // Query the products table to get the count of announced products by the seller
                const announcedProductsResults = await queryAsync('SELECT COUNT(*) as announcedProducts FROM Products WHERE seller_id = ?', [sellerId]);

                const announcedProducts = announcedProductsResults[0].announcedProducts;

                // Query the products table to get the count of available products announced by the seller
                const availableProductsResults = await queryAsync('SELECT COUNT(*) as availableProducts FROM Products WHERE seller_id = ? AND available = 1', [sellerId]);

                const availableProducts = availableProductsResults[0].availableProducts;

                // Add sales, total sales value, announced products, available products, and last 5 transactions information to seller data
                sellerData.totalSales = totalSales;
                sellerData.canceledSales = canceledSales;
                sellerData.totalSalesValue = totalSalesValue;
                sellerData.announcedProducts = announcedProducts;
                sellerData.availableProducts = availableProducts;
                sellerData.lastTransactions = lastTransactionsResults;

                res.status(200).json(sellerData);
            } else {
                res.status(404).json({ error: 'Seller not found' });
            }
        } else {
            res.status(404).json({ error: 'Product not found' });
        }
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
    }
};

const getProductBySlug = async (req, res) => {
    const slug = req.params.slug;
    try {
        // Fetch product details along with associated categories, SKU, slug, and seller verification status
        const product = await queryAsync(`
            SELECT 
                p.*, 
                (SELECT verified FROM users WHERE id = p.seller_id) AS is_seller_verified,
                GROUP_CONCAT(CONCAT('{ "categoryName": "', c.name, '", "category_id": ', pc.category_id, '}')) AS categories
            FROM 
                products p
            LEFT JOIN
                product_categories pc ON p.id = pc.product_id
            LEFT JOIN
                categories c ON pc.category_id = c.id
            WHERE 
                p.slug = ?
            GROUP BY
                p.id
        `, [slug]);

        if (product.length === 0) {
            return res.status(404).json({ error: 'Product not found' });
        }

        const productId = product[0].id;

        // Fetch images associated with the product
        const productImages = await queryAsync('SELECT id, image_link FROM product_images WHERE product_id = ?', [productId]);

        // Add full image paths to the product images
        const fullProductImages = productImages.map(image => ({
            ...image,
            imageUrl: `http://localhost:${process.env.PORT}/uploads/products/${image.image_link}`
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

function removeAccents(str) {
    return str.normalize('NFD')
        .toLowerCase()
        .replace(/[\u0300-\u036f]/g, char => {
            const base = char.charCodeAt(0) - 0x300;
            return String.fromCharCode(base);
        })
        .replace(/[^a-z0-9 -]/g, '')
        .replace(/\s+/g, '-');
}

// Generate SKU based on seller ID, product name, brand, and model

async function generateUniqueSKU(sellerId, productId, isSellerVerified) {

    const randomPart = Math.floor(Math.random() * 999999);

    let sku = `${sellerId}${productId}${isSellerVerified ? '1' : '0'}${randomPart.toString()}`;

    const skuExists = await isSKUEXistsInDatabase(sku);

    while (skuExists) {
        const randomPart = Math.floor(Math.random() * 9999);
        sku = `${sellerId}${productId}${isSellerVerified ? '1' : '0'}${randomPart.toString()}`;
    }

    sku = sku.padStart(16, '0');

    return sku;
}

async function isSKUEXistsInDatabase(sku) {
    try {
        // Assuming queryAsync is a function that executes SQL queries and returns a promise
        const [{ count }] = await queryAsync('SELECT COUNT(*) AS count FROM products WHERE sku = ?', [sku]);

        // If the count is greater than 0, SKU exists in the database
        return count > 0;
    } catch (error) {
        console.error('Error checking SKU in database:', error);
        // Return false or handle the error according to your application's logic
        return false;
    }
}

// Generate slug based on product name
function generateSlug(productName) {
    return removeAccents(productName);
}

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

        // Generate SKU and Slug
        const sku = generateSlug(name);
        const slug = generateSlug(name);

        // Insert product details into the products table along with seller verification status, SKU, and Slug
        const result = await queryAsync('INSERT INTO products (seller_id, name, description, brand, model, product_condition, price, available, sku, slug) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', [seller_id, name, description, brand, model, product_condition, price, available, sku, slug]);

        const productId = result.insertId;

        // Update SKU and Slug with actual product ID
        const updatedSlug = `${slug}-${productId}`;
        const updatedSku = `${await generateUniqueSKU(seller_id, productId, verified)}`;
        await queryAsync('UPDATE products SET slug = ?, sku = ? WHERE id = ?', [updatedSlug, updatedSku, productId]);

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

module.exports = { getProducts, getProductById, createProduct, updateProductById, getSellerInfo, deleteProductById, getProductBySlug };
