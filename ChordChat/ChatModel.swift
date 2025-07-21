struct ChatModel {
    var textEditor: TextEditorModel

    init() {
        self.textEditor = TextEditorModel()
    }

    public var text: String {
        textEditor.text
    }

    public var textSelection: Range<String.Index> {
        //        textEditor.textSelection
        textEditor.textEditorState.textSelection
    }

    public mutating func updateText(
        newText: String,
        textSelection: Range<String.Index>
    ) {
        var updateCommand: any TextCommand = UpdateTextCommand(
            newText: newText,
            textSelection: textSelection
        )
        textEditor.execute(textCommand: &updateCommand)
    }

    public mutating func undo() {
        var undoCommand: any TextCommand = UndoCommand()
        textEditor.execute(textCommand: &undoCommand)
    }

    public mutating func redo() {
        print("reeee")
        var redoCommand: any TextCommand = RedoCommand()
        textEditor.execute(textCommand: &redoCommand)
    }
}
