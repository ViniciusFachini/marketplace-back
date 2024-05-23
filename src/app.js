const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const bodyParser = require('body-parser');
const { register, login, updateUser, getProductsFromUser, getAllInfoFromUser, getUserById, getUsers } = require('./controllers/authController');
const path = require('path')
const { handleSingleImageUpload } = require('./middleware/uploadsMiddleware');

const productsRouter = require('./routes/productsRoutes');
const categoriesRouter = require('./routes/categoriesRoutes');
const addressesRouter = require('./routes/addressesRoutes');
const messagesRoutes = require('./routes/messagesRoutes');
const showcasesRoutes = require('./routes/showcasesRoutes');
const { verifyToken } = require('./middleware/authentication');

dotenv.config();

// Initialize Express application
const app = express();
const PORT = process.env.PORT || 3001;

// Middleware
app.use(cors()); // Enable CORS
app.use(bodyParser.json()); // Parse JSON bodies

app.post('/users/login', login);
app.post('/users/register', handleSingleImageUpload, register);
app.patch('/users/update/:id', verifyToken, handleSingleImageUpload, updateUser);
app.get('/users/', getUsers);
app.get('/users/:id', getUserById);
app.get('/users/:id/products', getProductsFromUser);
app.get('/users/:id/info', getAllInfoFromUser);

app.use('/products', productsRouter);
app.use('/categories', categoriesRouter);
app.use('/addresses', addressesRouter);
app.use('/messages', messagesRoutes);
app.use('/showcases', showcasesRoutes);

app.use('/uploads/products', express.static(path.join(__dirname, '..', 'uploads', 'products')))
app.use('/uploads/users', express.static(path.join(__dirname, '..', 'uploads', 'users')))
app.use('/uploads/misc', express.static(path.join(__dirname, '..', 'uploads', 'misc')))


app.get('*', (req, res) => {
  res.status(404).json({ error: { type: "Not Found!", message: "The content you are looking for was not found!" } });
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
