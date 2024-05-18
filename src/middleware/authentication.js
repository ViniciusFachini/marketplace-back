const jwt = require('jsonwebtoken');
const dotenv = require('dotenv');
dotenv.config();

const verifyToken = (req, res, next) => {
    const token = req.headers.authorization;
    
    if (!token) {
        res.status(403).json({ error: 'Token não fornecido' });
        return;
    }
    
    jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
        if (err) {
            res.status(401).json({ error: 'Falha ao autenticar token' });
            return;
        }
        req.user = decoded;  // Now JavaScript knows that 'user' is a valid property on req
        next();
    });
};

const getUserIdFromToken = (req, res, next) => {
    try {
        // Extract the token from the Authorization header
        const token = req.headers.authorization;

        // Verify the token and decode it
        const decodedToken = jwt.verify(token, process.env.JWT_SECRET);

        // Extract the user ID from the decoded token
        const userId = decodedToken.id;

        // Add the user ID to the request object
        req.userId = userId;

        // Call next middleware or route handler
        next();
    } catch (error) {
        // If there's an error (e.g., token is invalid), return an error response
        console.error('Error verifying token:', error);
        return res.status(401).json({ error: 'Unauthorized' });
    }
};

module.exports = getUserIdFromToken;


const getUserIdMiddleware = (req, res, next) => {
    const token = req.headers.authorization;

    try {
        if (token) {
            const decodedToken = jwt.verify(token, process.env.JWT_SECRET); // Assuming your decoded token has an 'id' field
            if (decodedToken) {
                req.userId = decodedToken.id;  // Now JavaScript knows that 'userId' is a valid property on req
            }
        }
        next();
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: 'Erro interno no servidor' });
    }
};

module.exports = { verifyToken, getUserIdFromToken, getUserIdMiddleware };
