const { v4: uuidv4 } = require('uuid');
const fs = require('fs');

function decodeBase64Image(dataString) {
    var matches = dataString.match(/^data:([A-Za-z-+\/]+);base64,(.+)$/);
    var response = {};

    if (matches.length !== 3) {
        return new Error('Invalid input string');
    }

    response.type = matches[1];
    response.data = Buffer.from(matches[2], 'base64');

    return response;
}

const handleSingleImageUpload = (req, res, next) => {
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
            const imageBuffer = decodeBase64Image(req.body.image);
            const imageTypeDetected = imageBuffer.type.match(/\/(.*?)$/);
    
            const imageName = `${uuidv4()}.${imageTypeDetected[1]}`;
            const finalPath = `${destinationDir}${imageName}`;
            
            req.body.imagePath = imageName;
    
            fs.writeFileSync(finalPath, imageBuffer.data, function () {});
            console.log('Single image saved:', finalPath);
        }
        next();
    } catch (err) {
        console.error(err);
        return res.status(500).json({ error: 'Internal Server Error' });
    }
};

const handleMultipleImageUpload = (req, res, next) => {
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
            req.body.images.forEach((image, index) => {
                const imageBuffer = decodeBase64Image(image);
                const imageTypeDetected = imageBuffer.type.match(/\/(.*?)$/);
    
                const imageName = `${uuidv4()}.${imageTypeDetected[1]}`;
                const finalPath = `${destinationDir}${imageName}`;
                
                req.body.imagePaths.push(imageName);

                fs.writeFileSync(finalPath, imageBuffer.data, function () {});
                console.log(`Image ${index + 1} saved: ${finalPath}`);
            });
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
