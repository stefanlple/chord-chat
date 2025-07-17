struct UpdateTextCommand: TextCommand, CustomStringConvertible {
    var description: String {
        snapshot?.text ?? "NO TEXT FOUND!"
    }
    
    var snapshot: TextEditorState?
    
    private var newText: String
    
    init(oldText: String, newText: String) {
        self.newText = newText
    }
    
    public mutating func execute(on textEditorModel: inout TextEditorModel){
        saveSnapshot(of: textEditorModel)
        textEditorModel.text = newText
        textEditorModel.chatHistory.pushToHistory(self)
    }
}
