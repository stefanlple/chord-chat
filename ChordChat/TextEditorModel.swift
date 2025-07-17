struct TextEditorModel {
    var textEditorState : TextEditorState
    var chatHistory : ChatHistory = ChatHistory()
    
    init(textEditorState: TextEditorState = TextEditorState()){
        self.textEditorState = textEditorState
    }
    
    var text : String{
        get {
            textEditorState.text
        }
        set {
            textEditorState.text = newValue
        }
    }
    
    var textSelection: Range<String.Index> {
        textEditorState.textSelection
    }
    
    
    public mutating func execute(textCommand : inout TextCommand) {
        textCommand.execute(on: &self)
        print(chatHistory.historyStack)
    }
}
