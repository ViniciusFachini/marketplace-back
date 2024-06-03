const sharp = require('sharp');
const { v4: uuidv4 } = require('uuid');
const fs = require('fs');
const path = require('path');

function decodeBase64Image(dataString) {
    const matches = String(dataString).match(/^data:([A-Za-z-+\/]+);base64,(.+)$/);
    const response = {};

    if (!matches || matches.length !== 3) {
        return new Error('Invalid input string');
    }

    response.type = matches[1];
    response.data = Buffer.from(matches[2], 'base64');

    return response;
}

const convertImageToWebp = async (inputBuffer, outputPath) => {
    if (!inputBuffer || inputBuffer.length === 0) {
        throw new Error('Invalid input buffer');
    }
    await sharp(inputBuffer)
        .toFormat('webp')
        .toFile(outputPath);
};

const handleSingleImageUpload = async (req, res, next) => {
    try {
        let destinationDir = './uploads/';
        if (req.originalUrl.startsWith('/register') || req.originalUrl.startsWith('/users')) {
            destinationDir += 'users/';
        } else if (req.originalUrl.startsWith('/products')) {
            destinationDir += 'products/';
        } else {
            destinationDir += 'misc/';
        }

        if (!fs.existsSync(destinationDir)) {
            fs.mkdirSync(destinationDir, { recursive: true });
        }

        if (req.body.image != null) {
            const imageData = req.body.image;
            const imageBuffer = decodeBase64Image(imageData);

            if (imageBuffer instanceof Error) {
                throw imageBuffer;
            }

            let imageName;
            if (typeof imageData === 'string' && (imageData.startsWith('data:application/octet-stream') || !imageData.startsWith('data:image/'))) {
                imageName = `${uuidv4()}.webp`;
                const finalPath = path.join(destinationDir, imageName);

                await convertImageToWebp(imageBuffer.data, finalPath);

                req.body.imagePath = imageName;
                console.log('Converted and saved webp image:', finalPath);
            } else {
                const imageTypeDetected = imageBuffer.type.match(/\/(.*?)$/);
                imageName = `${uuidv4()}.${imageTypeDetected[1]}`;
                const finalPath = path.join(destinationDir, imageName);

                fs.writeFileSync(finalPath, imageBuffer.data);
                req.body.imagePath = imageName;
                console.log('Single image saved:', finalPath);
            }
        }
        next();
    } catch (err) {
        console.error(err);
        return res.status(500).json({ error: 'Internal Server Error' });
    }
};

const handleMultipleImageUpload = async (req, res, next) => {
    try {
        let destinationDir = './uploads/';
        if (req.originalUrl.startsWith('/register') || req.originalUrl.startsWith('/users')) {
            destinationDir += 'users/';
        } else if (req.originalUrl.startsWith('/products')) {
            destinationDir += 'products/';
        } else {
            destinationDir += 'misc/';
        }

        if (!fs.existsSync(destinationDir)) {
            fs.mkdirSync(destinationDir, { recursive: true });
        }

        if (req.body.images && Array.isArray(req.body.images)) {
            req.body.imagePaths = [];
            for (let index = 0; index < req.body.images.length; index++) {
                const imageData = req.body.images[index];
                const imageBuffer = decodeBase64Image(imageData);

                if (imageBuffer instanceof Error) {
                    throw imageBuffer;
                }

                let imageName;
                if (typeof imageData === 'string' && (imageData.startsWith('data:application/octet-stream') || !imageData.startsWith('data:image/'))) {
                    imageName = `${uuidv4()}.webp`;
                    const finalPath = path.join(destinationDir, imageName);

                    await convertImageToWebp(imageBuffer.data, finalPath);

                    req.body.imagePaths.push(imageName);
                    console.log(`Converted and saved webp image ${index + 1}:`, finalPath);
                } else {
                    const imageTypeDetected = imageBuffer.type.match(/\/(.*?)$/);
                    imageName = `${uuidv4()}.${imageTypeDetected[1]}`;
                    const finalPath = path.join(destinationDir, imageName);

                    fs.writeFileSync(finalPath, imageBuffer.data);
                    req.body.imagePaths.push(imageName);
                    console.log(`Image ${index + 1} saved:`, finalPath);
                }
            }
        } else {
            console.log('No images found in request.');
        }
        next();
    } catch (err) {
        console.error(err);
        return res.status(500).json({ error: 'Internal Server Error' });
    }
};

module.exports = { handleSingleImageUpload, handleMultipleImageUpload };
