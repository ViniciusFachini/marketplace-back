const fs = require('fs');
const { queryAsync } = require('../db');
const path = require('path')

const removeUnusedImages = async () => {
    try {
        // Step 1: Query the product_images table to get all distinct image links
        const allImages = fs.readdirSync('./uploads/products');

        // Step 2: Query the products table to get all distinct image links associated with products
        const productImagesResult = await queryAsync('SELECT DISTINCT id, image_link FROM product_images');

        // Extract image links from the query results
        const productImages = productImagesResult.map(row => row.image_link);

        // const productImages = productImagesResult.map(row => {
            //     console.log(uuidRegex.test(row.image_link))
            // });s
        const uuidRegex = /^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\.(avif|webp|jpeg|jpg|png)$/
            
        // Step 3: Find images not associated with any product
        const unusedImages = allImages.filter(image => !productImages.includes(image) || !productImages.image_link == null || !uuidRegex.test(image));

        // console.log(unusedImages)

        // Step 4: Delete unused images from the system
        unusedImages.forEach((image) => {
            console.log(image);
            fs.unlink(path.normalize(path.join(__dirname, '..', '..', 'uploads', 'products', image)), (err) => {
                if (err) {
                    console.log(err);
                } else {
                    console.log(`Deleted unused image: ${image}`);
                }
            });
        });

        await queryAsync('DELETE FROM product_images WHERE product_id IS NULL');

        // console.log(response)

        console.log('Unused images removed successfully.');
    } catch (error) {
        console.error('Error removing unused images:', error);
    }
};

module.exports = { removeUnusedImages };