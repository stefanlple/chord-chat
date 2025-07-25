import SwiftUI
import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var model: ChatModel
    var textCounter = 0
    var selectionCounter = 1
    private var cancellables = Set<AnyCancellable>()

    var messages : [Message]{
        model.messages
    }
    
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
    
    var currentSenderName: String {
        model.senderName
    }

    init() {
        model = ChatModel(webSocketUrl: "ws://127.0.0.1:8080", senderName: "TaylorSwifty")
        model.webSocketManager.$messages
                    .sink { [weak self] _ in
                        self?.objectWillChange.send()
                    }
                    .store(in: &cancellables)
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

    func send() {
        model.send()
    }
}
