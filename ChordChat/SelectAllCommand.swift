struct SelectAllCommand: TextCommand {
    var snapshot: TextEditorState?

    mutating func execute(on textEditorModel: inout TextEditorModel) {
        let currentText = textEditorModel.textEditorState.text
        let selectedAllRange = currentText.startIndex..<currentText.endIndex
        textEditorModel.textEditorState.textSelection = selectedAllRange
    }
}
