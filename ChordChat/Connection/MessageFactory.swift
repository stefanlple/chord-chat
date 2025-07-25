import Foundation

struct MessageFactory {
    var senderInfo: String

    func createMessage(message: String) -> Message {
        return Message(
            messageType: MessageType.message, senderName: senderInfo,
            timeStamp: TimeStampUtil.getDateNowMiliseconds(), message: message)
    }

    func error() {

    }
}
