import Foundation

struct Message : Codable {
    let messageType: MessageType
    let senderName: String
    let timeStamp: String
    let message: String
}
