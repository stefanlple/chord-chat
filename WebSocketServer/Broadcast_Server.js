const WebSocket = require("ws");

const wss = new WebSocket.Server({ port: 8080 });
console.log("Server started");

wss.on("connection", (ws) => {
    console.log("Client connected");

    ws.on("message", (message) => {
        console.log("Received:", message);
        try {
            const parsed = JSON.parse(message);

            const {
                messageType,
                senderName,
                timeStamp,
                message: msgText,
            } = parsed;

            console.log("Type:", messageType);
            console.log("From:", senderName);
            console.log("Time:", timeStamp);
            console.log("Message:", msgText);

            switch (messageType) {
                case "message":
                    console.log(`[CHAT] ${senderName}: ${msgText}`);
                    break;
                case "join":
                    console.log(`[JOIN] ${senderName} joined at ${timeStamp}`);
                    break;
                case "leave":
                    console.log(`[LEAVE] ${senderName} left at ${timeStamp}`);
                    break;
                default:
                    console.log(`[UNKNOWN TYPE]`, parsed);
                    break;
            }

            wss.clients.forEach((client) => {
                if (client.readyState === WebSocket.OPEN) {
                    client.send(JSON.stringify(parsed));
                }
            });
        } catch (e) {
            console.error("Invalid JSON", e);

            const errorResponse = {
                messageType: "ERROR",
                senderName: "Server",
                timeStamp: new Date().toISOString(),
                message: "Invalid JSON format" + e,
            };

            if (ws.readyState === WebSocket.OPEN) {
                ws.send(JSON.stringify(errorResponse));
            }
        }
    });

    ws.on("close", () => {
        console.log("Client disconnected");
    });
});
