struct RedoCommand: TextCommand {
    var description: String {
        snapshot?.text ?? "NO VALUE FOUND!"
    }

    var snapshot: TextEditorState?

    mutating func execute(on textEditorModel: inout TextEditorModel) {
        let command = textEditorModel.chatHistory.getNextHistory()
        if let snapshot = command.snapshot {
            textEditorModel.textEditorState = snapshot
        }
    }
}
