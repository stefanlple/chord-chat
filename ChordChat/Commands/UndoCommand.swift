struct UndoCommand: TextCommand, CustomStringConvertible {
    var snapshot: TextEditorState?

    var description: String {
        "UNDO " + (snapshot?.text ?? "NO VALUE FOUND!")
    }

    mutating func execute(on textEditorModel: inout TextEditorModel) {
        do {
            let command = try textEditorModel.chatHistory.getPreviousHistory()
            if let snapshot = command.snapshot {
                textEditorModel.textEditorState = snapshot
            }
        } catch ChatHistoryError.pointerOutOfBound {
            print("ERROR: History Pointer out of bounds")
        } catch {
            print("ERROR: Unknown Error")
        }
    }
}
