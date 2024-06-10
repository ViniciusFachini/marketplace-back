const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const bodyParser = require('body-parser');
const http = require('http');
const path = require('path');
const { handleSingleImageUpload } = require('./middleware/uploadsMiddleware');
const { verifyToken } = require('./middleware/authentication');
const { searchProducts } = require('./controllers/productController');
const { removeUnusedImages } = require('./service/cleaner');

// Require chat module
const { setupSocket } = require('./service/chat');

// Import routers
const productsRouter = require('./routes/productsRoutes');
const categoriesRouter = require('./routes/categoriesRoutes');
const addressesRouter = require('./routes/addressesRoutes');
const transactionsRoutes = require('./routes/transactionsRoutes');
const reviewsRoutes = require('./routes/reviewsRoutes');
const messagesRoutes = require('./routes/messagesRoutes');
const showcasesRoutes = require('./routes/showcasesRoutes');
const { register, login, updateUser, getOrdersByUserId, getProductsFromUser, getAllInfoFromUser, getUserById, getUsers } = require('./controllers/authController');

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3001;

const server = http.createServer(app);

// Use the setupSocket function to initialize socket.io
const io = setupSocket(server);

module.exports = io;

// Middleware
app.use(cors({
  origin: '*', // Change '*' to your specific origin if necessary
  methods: ['GET', 'POST', 'PATCH', 'DELETE'], // Allowed methods
  allowedHeaders: ['Content-Type', 'Authorization', 'Referer'], // Allowed headers
  credentials: true, // Allow cookies if needed
}));

app.use(bodyParser.json({ limit: '50mb' }));
app.use(bodyParser.urlencoded({ limit: '50mb', extended: true }));

// API routes
app.get('/search', searchProducts);

// Authentication routes
app.post('/users/login', login);
app.post('/users/register', handleSingleImageUpload, register);
app.patch('/users/update/:id', verifyToken, handleSingleImageUpload, updateUser);
app.get('/users/', getUsers);
app.get('/users/:id', verifyToken, getUserById);
app.get('/users/:id/products', verifyToken, getProductsFromUser);
app.get('/users/:id/info', verifyToken, getAllInfoFromUser);
app.get('/users/:id/orders', verifyToken, getOrdersByUserId);

// Other routes
app.use('/products', productsRouter);
app.use('/categories', categoriesRouter);
app.use('/addresses', addressesRouter);
app.use('/messages', messagesRoutes);
app.use('/showcases', showcasesRoutes);
app.use('/transactions', transactionsRoutes);
app.use('/reviews', reviewsRoutes);

// Serve static files
app.use('/uploads/products', express.static(path.join(__dirname, '..', 'uploads', 'products')));
app.use('/uploads/users', express.static(path.join(__dirname, '..', 'uploads', 'users')));
app.use('/uploads/misc', express.static(path.join(__dirname, '..', 'uploads', 'misc')));

// Clean unused images
removeUnusedImages();

// 404 route
app.get('*', (req, res) => {
    res.status(404).json({ error: { type: "Not Found!", message: "The content you are looking for was not found!" } });
});

// Start the server
server.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
