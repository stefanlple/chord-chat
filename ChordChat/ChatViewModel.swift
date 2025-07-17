import SwiftUI

class ChatViewModel: ObservableObject {
    @Published private var model: ChatModel
    
    var text : String {
        get {
            model.text
        }
        set {
            model.updateText(oldText: text, newText: newValue)
        }
    }
    
    init() {
        self.model = ChatModel()
    }

    func undo() {
        model.undo()
    }

    func redo() {
        model.redo()
    }

    func cut() {}

    func copy() {}

    func paste() {}

    func send() {}

}
