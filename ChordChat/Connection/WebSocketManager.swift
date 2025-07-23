import Foundation

final class WebSocketManager {
    static let singleton = WebSocketManager()
    private var webSocketTask: URLSessionWebSocketTask?

    func connect(to urlString: String){
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        let session = URLSession(configuration: .default)
        webSocketTask = session.webSocketTask(with: url)
        webSocketTask?.resume()
        print("connection established")
    }
    
    func send(message: Message) {
        
    }
    
    func receive() {}
}
