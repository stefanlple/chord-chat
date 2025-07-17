struct ChatModel {
    var textEditor : TextEditorModel
    
    init() {
        self.textEditor = TextEditorModel()
    }
    
    public var text : String {
        textEditor.text
    }
    
    public var selection : Range<String.Index> {
        textEditor.textSelection
    }
    
    public mutating func updateText(oldText : String, newText: String) {
        var updateCommand: any TextCommand = UpdateTextCommand(oldText: oldText, newText: newText)
        textEditor.execute(textCommand: &updateCommand)
    }

    public mutating func undo() {
        var undoCommand: any TextCommand = UndoCommand()
        textEditor.execute(textCommand: &undoCommand)
    }
    
    public mutating func redo(){
        print("reeee")
        var redoCommand : any TextCommand = RedoCommand()
        textEditor.execute(textCommand: &redoCommand)
    }
}
