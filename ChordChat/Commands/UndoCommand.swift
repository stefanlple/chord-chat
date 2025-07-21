struct UndoCommand: TextCommand, CustomStringConvertible {
    var description: String {
        "UNDO " + (snapshot?.text ?? "NO VALUE FOUND!")
    }

    var snapshot: TextEditorState?

    mutating func execute(on textEditorModel: inout TextEditorModel) {
        let command = textEditorModel.chatHistory.getPreviousHistory()
        if let snapshot = command.snapshot {
            textEditorModel.textEditorState = snapshot
        }
    }
}
