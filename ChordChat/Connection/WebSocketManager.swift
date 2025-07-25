import Foundation

final class WebSocketManager {
    static let singleton = WebSocketManager()
    private var webSocketTask: URLSessionWebSocketTask?
    private var messagesHandlers : [String: WebSocketHandler] = [:]
    @Published var messages = [Message]()
    
    func connect(to urlString: String){
        guard let url = URL(string: urlString) else {
            print("ERROR: Invalid URL")
            return
        }
        let session = URLSession(configuration: .default)
        webSocketTask = session.webSocketTask(with: url)
        webSocketTask?.resume()
        
        webSocketTask?.sendPing { error in
            if let error = error {
                print("ERROR: Failed to connect – \(error.localizedDescription)")
            } else {
                print("INFO: Connection established and ping successful")
                self.receive()
            }
        }
    }
    
    private var chatModel: ChatModel?
        
    func setChatModel(_ model: ChatModel) {
            self.chatModel = model
    }
        
    func send(message: Message) async {
        guard let webSocketTask = webSocketTask else {
            print("ERROR: WebSocket is not connected")
            return
        }
        
        guard let serialisedMessage = SerializeUtil.serialize(object: message) else { return }
        let wsMessage: URLSessionWebSocketTask.Message
        wsMessage = URLSessionWebSocketTask.Message.string(serialisedMessage)
        do {
            try await webSocketTask.send(wsMessage)
        } catch {
            print("ERROR: Failed sending message – \(error.localizedDescription)")
        }
    }
    
    func receive()  {
        guard let webSocketTask = webSocketTask else {
            print("ERROR: WebSocket is not connected")
            return
        }
        webSocketTask.receive{ [weak self] result in
            switch result {
            case .success(let message):
                print("successfully received message")
                self?.handleReceivedMessage(message: message)
            case .failure(let error):
                print("ERROR: Failed sending message – \(error.localizedDescription)")
            }
        }
    }
    
    func handleReceivedMessage(message: URLSessionWebSocketTask.Message){
        switch message {
        case .string(let string):
            guard let message = SerializeUtil.deserialize(jsonString: string, type: Message.self) else { return }
//            messagesHandlers[message.messageType.rawValue]?.handle(message: message)
            DispatchQueue.main.async {
                self.messages.append(message)
                print(self.messages)
            }
        case .data(_):
            // TODO: To be implemented
            print("ERROR: Receive data - Ehh kann ich nicht handlen")
        @unknown default:
            print("ERROR: Unknown Error")
        }
        self.receive()
    }
    
    
    func registerHandlers(messageType: MessageType, handler: WebSocketHandler) {
        messagesHandlers[messageType.rawValue] = handler
    }
    
    

}
