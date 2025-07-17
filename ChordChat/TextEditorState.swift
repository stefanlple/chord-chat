struct TextEditorState{
    
    var text : String
    var textSelection : Range<String.Index>
    
    init(text: String = "", textSelection: Range<String.Index>? = nil) {
        self.text = text
        self.textSelection = textSelection ?? text.startIndex..<text.endIndex
    }
}
