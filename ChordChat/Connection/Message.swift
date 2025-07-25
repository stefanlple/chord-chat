import Foundation

struct Message: Codable, Identifiable {
    var id: String {
        "\(messageType) - \(senderName) - \(timeStamp) - \(message)"
    }

    let messageType: MessageType
    let senderName: String
    let timeStamp: String
    let message: String
}
