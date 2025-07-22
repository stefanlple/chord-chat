struct ChatModel {
    var textEditor: TextEditorModel

    init() {
        self.textEditor = TextEditorModel()
    }

    public var text: String {
        textEditor.text
    }

    public var textSelection: Range<String.Index> {
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
        var redoCommand: any TextCommand = RedoCommand()
        textEditor.execute(textCommand: &redoCommand)
    }
    
    public mutating func selectAll() {
        var selectAllCommand : any TextCommand = SelectAllCommand()
        textEditor.execute(textCommand: &selectAllCommand)
    }
    
    public mutating func copy() {
        var copyCommand : any TextCommand = CopyCommand()
        textEditor.execute(textCommand: &copyCommand)
    }
    
    public mutating func paste() {
        var pasteCommand : any TextCommand = PasteCommand()
        textEditor.execute(textCommand: &pasteCommand)
    }
    
    public mutating func cut() {
        var cutCommand : any TextCommand = CutCommand()
        textEditor.execute(textCommand: &cutCommand)
    }
}
