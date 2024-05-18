const { queryAsync } = require('../db');

const authorize = async (req, res, next) => {
    try {
        const userId = req.user?.id;

        if (!userId) {
            res.status(403).json({ error: 'Token inválido ou não fornecido' }); // Return to exit the function
            return;
        }

        // Query the database to get user permissions
        const userPermissions = await queryAsync('SELECT user_type FROM users WHERE id = ?', [userId]);

        if (userPermissions.length === 0) {
            res.status(403).json({ error: 'Usuário não encontrado' }); // Return to exit the function
            return;
        }

        // Check if the user has the required permission ('Admin' role)
        if (userPermissions[0].user_type !== "Admin") {
            res.status(403).json({ error: 'Acesso não autorizado' }); // Return to exit the function
            return;
        }

        // If all checks pass, proceed to the next middleware or route handler
        next();
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Erro interno no servidor' });
    }
};

module.exports = { authorize };
