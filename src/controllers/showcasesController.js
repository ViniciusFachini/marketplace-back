const { queryAsync } = require('../db');

// Controller to get all showcases
// Controller to get all showcases with associated items
// Controller to get all showcases with associated product details
// Controller to get all showcases with associated product details
const getShowcases = async (req, res) => {
    try {
        const showcases = await queryAsync('SELECT * FROM showcases');

        for (let i = 0; i < showcases.length; i++) {
            const showcaseId = showcases[i].id;

            const items = await queryAsync(`
            SELECT 
                sp.*, 
                p.id AS product_id, 
                p.seller_id, 
                p.name, 
                p.sku,
                p.slug,
                GROUP_CONCAT(DISTINCT CONCAT_WS(':', c.name, pc.category_id)) AS categories, 
                p.brand, 
                p.model, 
                p.product_condition, 
                p.price, 
                p.available, 
                p.created_at, 
                u.verified AS is_seller_verified,
                GROUP_CONCAT(DISTINCT pi.image_link) AS images
            FROM 
                showcase_products sp 
            JOIN 
                products p ON sp.product_id = p.id 
            LEFT JOIN 
                product_categories pc ON p.id = pc.product_id
            LEFT JOIN 
                categories c ON pc.category_id = c.id
            JOIN 
                users u ON p.seller_id = u.id 
            JOIN 
                product_images pi ON p.id = pi.product_id
            WHERE 
                sp.showcase_id = ? AND
                p.available = 1
            GROUP BY
                sp.id, p.id;        
            `, [showcaseId]);

            items.forEach(item => {
                item.images = item.images.split(',').map(image_link => ({
                    image_link,
                    imageUrl: `http://${process.env.HOST}:8080/uploads/products/${image_link}`
                }));
                item.categories = item.categories.split(',').map(category => {
                    const [categoryName, categoryId] = category.split(':');
                    return { categoryName, category_id: parseInt(categoryId) };
                });
            });

            showcases[i].items = items;
        }

        res.json(showcases);
    } catch (error) {
        console.error('Error fetching showcases:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const getShowcaseById = async (req, res) => {
    const showcaseId = parseInt(req.params.id);
    try {
        const showcase = await queryAsync('SELECT * FROM showcases WHERE id = ?', [showcaseId]);

        if (showcase.length === 0) {
            return res.status(404).json({ error: 'Showcase not found' });
        }

        const items = await queryAsync(`
        SELECT 
            sp.*, 
            p.id AS product_id, 
            p.seller_id, 
            p.name, 
            p.sku,
            p.slug,
            GROUP_CONCAT(DISTINCT CONCAT_WS(':', c.name, pc.category_id)) AS categories, 
            p.brand, 
            p.model, 
            p.product_condition, 
            p.price, 
            p.available, 
            p.created_at, 
            u.verified AS is_seller_verified,
            (SELECT GROUP_CONCAT(image_link) FROM product_images WHERE product_id = p.id) AS images
        FROM 
            showcase_products sp 
        JOIN 
            products p ON sp.product_id = p.id 
        LEFT JOIN 
            product_categories pc ON p.id = pc.product_id
        LEFT JOIN 
            categories c ON pc.category_id = c.id
        JOIN 
            users u ON p.seller_id = u.id 
        WHERE 
            sp.showcase_id = ? AND
            p.available = 1
        GROUP BY
            sp.id, p.id;    
        `, [showcaseId]);

        items.forEach(item => {
            item.images = item.images.split(',').map(image_link => ({
                image_link,
                imageUrl: `http://${process.env.HOST}:8080/uploads/products/${image_link}`
            }));
            item.categories = item.categories.split(',').map(category => {
                const [categoryName, categoryId] = category.split(':');
                return { categoryName, category_id: parseInt(categoryId) };
            });
        });

        showcase[0].items = items;

        res.json(showcase[0]);
    } catch (error) {
        console.error('Error fetching showcase:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

// Controller to create a new showcase
const createShowcase = async (req, res) => {
    const { title, subtitle, link } = req.body;
    try {
        // Insert showcase details into the showcases table
        const result = await queryAsync('INSERT INTO showcases (title, subtitle, link) VALUES (?, ?, ?)', [title, subtitle, link]);

        const showcaseId = result.insertId;

        res.status(201).json({ message: 'Showcase created successfully', id: showcaseId });
    } catch (error) {
        console.error('Error creating showcase:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

// Controller to update a showcase by ID using PATCH
const updateShowcaseById = async (req, res) => {
    const showcaseId = parseInt(req.params.id);
    const updates = req.body;
    try {
        let updateQuery = 'UPDATE showcases SET ';
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
        updateParams.push(showcaseId);

        const result = await queryAsync(updateQuery, updateParams);

        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Showcase not found' });
        }
        res.json({ message: 'Showcase updated successfully' });
    } catch (error) {
        console.error('Error updating showcase:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

// Controller to delete a showcase by ID
const deleteShowcaseById = async (req, res) => {
    const showcaseId = parseInt(req.params.id);
    try {
        const result = await queryAsync('DELETE FROM showcases WHERE id = ?', [showcaseId]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Showcase not found' });
        }
        res.json({ message: 'Showcase deleted successfully' });
    } catch (error) {
        console.error('Error deleting showcase:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

// Controller to add an item to a showcase
// Controller to add an item to a showcase
const addItemToShowcase = async (req, res) => {
    const showcaseId = parseInt(req.params.showcaseId);
    const { itemId } = req.body;
    try {
        // Check if the showcase and item exist
        const [showcaseExists] = await queryAsync('SELECT id FROM showcases WHERE id = ?', [showcaseId]);
        const [itemExists] = await queryAsync('SELECT id FROM products WHERE id = ?', [itemId]);

        if (!showcaseExists || !itemExists) {
            return res.status(404).json({ error: 'Showcase or item not found' });
        }

        // Check if the item is already associated with the showcase
        const [existingAssociation] = await queryAsync('SELECT id FROM showcase_products WHERE showcase_id = ? AND product_id = ?', [showcaseId, itemId]);

        if (existingAssociation) {
            return res.status(400).json({ error: 'Item is already in the showcase' });
        }

        // Add the item to the showcase
        await queryAsync('INSERT INTO showcase_products (showcase_id, product_id) VALUES (?, ?)', [showcaseId, itemId]);

        res.status(201).json({ message: 'Item added to showcase successfully' });
    } catch (error) {
        console.error('Error adding item to showcase:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};


// Controller to remove an item from a showcase
// Controller to remove an item from a showcase
const removeItemFromShowcase = async (req, res) => {
    const showcaseId = parseInt(req.params.showcaseId);
    const { itemId } = req.body;
    try {
        // Check if the showcase and item exist
        const [showcaseExists] = await queryAsync('SELECT id FROM showcases WHERE id = ?', [showcaseId]);
        const [itemExists] = await queryAsync('SELECT id FROM products WHERE id = ?', [itemId]);

        // Check if the item is associated with the showcase
        const [associationExists] = await queryAsync('SELECT id FROM showcase_products WHERE showcase_id = ? AND product_id = ?', [showcaseId, itemId]);

        if (!showcaseExists || !itemExists || !associationExists) {
            return res.status(404).json({ error: 'Showcase, item, or association not found' });
        }

        // Remove the item from the showcase
        await queryAsync('DELETE FROM showcase_products WHERE showcase_id = ? AND product_id = ?', [showcaseId, itemId]);

        res.json({ message: 'Item removed from showcase successfully' });
    } catch (error) {
        console.error('Error removing item from showcase:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};


module.exports = { getShowcases, getShowcaseById, createShowcase, updateShowcaseById, deleteShowcaseById, addItemToShowcase, removeItemFromShowcase };
