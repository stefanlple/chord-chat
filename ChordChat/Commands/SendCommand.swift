import Foundation

struct SendCommand : TextCommand {
    var snapshot: TextEditorState?
    let senderName: String
    
    mutating func execute(on textEditorModel: inout TextEditorModel) {
        let dateNowMiliseconds = Date.now.timeIntervalSince1970
        let stringifiedDateNowMiliseconds = String(dateNowMiliseconds)
        
        let message = Message(messageType: MessageType.message, senderName: self.senderName, timeStamp: stringifiedDateNowMiliseconds, message: textEditorModel.text)
        Task {
            await WebSocketManager.singleton.send(message: message)
        }
        cleanup(of: &textEditorModel)
    }
    
    func cleanup(of textEditorModel: inout TextEditorModel){
        textEditorModel.chatHistory.clearHistory()
        textEditorModel.text = ""
        textEditorModel.textSelection = textEditorModel.text.startIndex..<textEditorModel.text.startIndex
    }
}
