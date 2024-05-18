const { v4: uuidv4 } = require('uuid');
const fs = require('fs');
const multer = require('multer');

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        // Determine the destination directory based on the request and file type
        let destinationDir = './uploads/';

        if (req.baseUrl == '/register') {
            destinationDir += `/users/`;
        } else if (req.baseUrl == '/products') {
            destinationDir += `${req.baseUrl}/`;
        } else {
            destinationDir += 'misc/';
        }

        // Create the directory if it doesn't exist
        if (!fs.existsSync(destinationDir)) {
            fs.mkdirSync(destinationDir, { recursive: true });
        }

        cb(null, destinationDir);
    },
    filename: function (req, file, cb) {
        const extension = file.originalname.split('.').pop();
        cb(null, `${uuidv4()}.${extension}`);
    }
});

const uploadSingle = multer({ storage: storage }).single('image');
const uploadMultiple = multer({ storage: storage }).array('images');

const handleSingleImageUpload = (req, res, next) => {
    uploadSingle(req, res, function (err) {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: 'Internal Server Error' });
        }
        if (!req.file) {
            return res.status(400).json({ error: 'No file uploaded' });
        }
        req.body.imagePath = req.file.filename;
        next();
    });
};

const handleMultipleImageUpload = (req, res, next) => {
    uploadMultiple(req, res, function (err) {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: 'Internal Server Error' });
        }
        if (!req.files || req.files.length === 0) {
            return res.status(400).json({ error: 'No files uploaded' });
        }
        req.body.imagePaths = req.files.map(file => file.filename);
        next();
    });
};

module.exports = { handleSingleImageUpload, handleMultipleImageUpload };
