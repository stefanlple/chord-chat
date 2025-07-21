import SwiftUI

class ChatViewModel: ObservableObject {
    @Published private var model: ChatModel
    var textCounter = 0
    var selectionCounter = 1

    var text: String {
        get {
            self.model.text
        }
        set {
            let range = self.model.text
            self.model.updateText(newText: newValue, textSelection: range.endIndex..<range.endIndex)
        }
    }

    var selection: TextSelection? {
        get {
            let range = self.model.textSelection
            return TextSelection(range: range)
        }
        set {
            guard let selection = newValue else { return }

            if case let .selection(range) = selection.indices {
                self.model.textEditor.textSelection = range
            }
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
