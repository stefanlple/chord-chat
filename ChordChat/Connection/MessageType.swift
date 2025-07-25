import Foundation

enum MessageType: String, Codable {
    case join = "JOIN"
    case leave = "LEAVE"
    case message = "MESSAGE"
    case error = "ERROR"
}
