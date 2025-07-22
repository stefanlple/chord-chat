struct UpdateTextCommand: TextCommand, CustomStringConvertible {
    private var newText: String

    // PreviousTextSelection to restore the old state of the snapshot. It is being passed by the View and retrieved directly from the model at that state
    private var previousTextSelection: Range<String.Index>

    var snapshot: TextEditorState?

    var description: String {
        guard let lowerBound = snapshot?.textSelection.lowerBound,
            let upperBound = snapshot?.textSelection.upperBound,
            let text = snapshot?.text
        else {
            return "ERROR"
        }
        return
            "UPDATE_TEXT ->  \(text) | Last Index: \(text.indices.count - 1) | Range: \(lowerBound)..<\(upperBound)"
    }

    init(newText: String, textSelection: Range<String.Index>) {
        self.newText = newText
        self.previousTextSelection = textSelection
    }

    // override default implementation
    public mutating func saveSnapshot(of textEditorModel: TextEditorModel) {
        snapshot = TextEditorState(text: textEditorModel.text, textSelection: previousTextSelection)

    }

    public mutating func execute(on textEditorModel: inout TextEditorModel) {
        saveSnapshot(of: textEditorModel)
        
        textEditorModel.text = newText
        do {
            try textEditorModel.chatHistory.pushToHistory(self)
        } catch ChatHistoryError.pointerOutOfBound {
            print("History Pointer out of bounds")
        } catch {
            print("Unknown Error")
        }
        
        let currentPointer = textEditorModel.chatHistory.historyPointer
        _ = textEditorModel.chatHistory.removeHistoryRange(startIndex: currentPointer + 1)

    }
}
