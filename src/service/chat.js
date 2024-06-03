// services/chat.js
const socketIo = require('socket.io');

let io;

function setupSocket(server) {
    io = socketIo(server, {
        cors: {
            origin: '*',
        }
    });

    io.on('connection', (socket) => {
        console.log('New client connected');

        socket.on('join', (userId) => {
            socket.join(userId.toString());
            console.log(`User ${userId} joined room ${userId}`);
        });

        socket.on('disconnect', () => {
            console.log('Client disconnected');
        });
    });

    return io;
}

function getIO() {
    if (!io) {
        throw new Error('Socket.io not initialized');
    }
    return io;
}

module.exports = { setupSocket, getIO };
