struct CutCommand : TextCommand {
    var snapshot: TextEditorState?
    
    mutating func execute(on textEditorModel: inout TextEditorModel) {
        saveSnapshot(of: textEditorModel)
        
        do {
            try textEditorModel.chatHistory.pushToHistory(self)
        } catch ChatHistoryError.pointerOutOfBound {
            print("ERROR: History Pointer out of bounds")
        }catch {
            print("ERROR: Unknown Error")
        }
        
        
        let currentText = textEditorModel.text
        let currentTextSelection = textEditorModel.textSelection
        textEditorModel.clipboard = String(currentText[currentTextSelection])
        
        textEditorModel.text.removeSubrange(currentTextSelection)
        textEditorModel.textSelection = currentTextSelection.lowerBound..<currentTextSelection.lowerBound
    }
}
