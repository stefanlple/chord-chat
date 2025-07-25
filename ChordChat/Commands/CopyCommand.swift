struct CopyCommand: TextCommand {
    var snapshot: TextEditorState?

    mutating func execute(on textEditorModel: inout TextEditorModel) {
        saveSnapshot(of: textEditorModel)

        let currentText = textEditorModel.text
        textEditorModel.clipboard = String(currentText[textEditorModel.textSelection])
    }
}
