import SwiftUI

class ChatViewModel: ObservableObject {
    @Published private var model: ChatModel
    var textCounter = 0
    var selectionCounter = 1

    var text: String {
        get {
            model.text
        }
        set {
            let range = model.text
            model.updateText(newText: newValue, textSelection: range.endIndex..<range.endIndex)
        }
    }

    var selection: TextSelection? {
        get {
            let range = model.textSelection
            return TextSelection(range: range)
        }
        set {
            guard let selection = newValue else { return }

            if case let .selection(range) = selection.indices {
                model.textEditor.textSelection = range
            }
        }
    }

    init() {
        model = ChatModel(webSocketUrl: "ws://localhost:8080")
    }

    func undo() {
        model.undo()
    }

    func redo() {
        model.redo()
    }
    
    func selectAll(){
        model.selectAll()
    }

    func copy() {
        model.copy()
    }
    
    func paste() {
        model.paste()
    }
    
    func cut() {
        model.cut()
    }

    func send() {}

}
