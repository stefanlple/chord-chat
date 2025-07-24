import Foundation

struct MessageFactory {
    var senderInfo : String
    
    func createMessage(message: String) -> Message {
        return Message(messageType: MessageType.message, senderName: senderInfo, timeStamp: getDateNowMiliseconds(), message: message)
    }
    
    func error() {
        
    }
    
    
    func getDateNowMiliseconds() -> String{
        let dateNowMiliseconds = Date.now.timeIntervalSince1970
        let stringifiedDateNowMiliseconds = String(dateNowMiliseconds)
        return stringifiedDateNowMiliseconds
    }
}
