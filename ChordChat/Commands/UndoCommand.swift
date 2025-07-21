struct UndoCommand: TextCommand, CustomStringConvertible {
    var description: String {
        "UNDO " + (snapshot?.text ?? "NO VALUE FOUND!")
    }

    var snapshot: TextEditorState?

    mutating func execute(on textEditorModel: inout TextEditorModel) {
        do {
            let command = try textEditorModel.chatHistory.getPreviousHistory()
            if let snapshot = command.snapshot {
                textEditorModel.textEditorState = snapshot
            }
        } catch ChatHistoryError.pointerOutOfBound {
            print("History Pointer out of bounds")
        } catch {
            print("Unknown Error")
        }
    }
}
