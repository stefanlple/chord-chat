protocol TextCommand {
    var snapshot: TextEditorState? { get set }

    mutating func execute(on textEditorModel: inout TextEditorModel)
    mutating func saveSnapshot(of textEditorModel: TextEditorModel)
}

extension TextCommand {
    mutating func saveSnapshot(of textEditorModel: TextEditorModel) {
        snapshot = textEditorModel.textEditorState
    }
}
