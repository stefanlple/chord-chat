import Foundation

struct SendCommand : TextCommand {
    var snapshot: TextEditorState?
    let senderName: String
    let messageFactory: MessageFactory
    
    mutating func execute(on textEditorModel: inout TextEditorModel) {
        let message = messageFactory.createMessage(message: textEditorModel.text)
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
