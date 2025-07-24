struct PasteCommand : TextCommand {
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
        
        // steps delete current selection. take the first start index and then insert text at that position
        let  selectionRange = textEditorModel.textSelection
        textEditorModel.text.removeSubrange(selectionRange)
        
        textEditorModel.text.insert(contentsOf: textEditorModel.clipboard, at: selectionRange.lowerBound)
        let newIndex = textEditorModel.text.index(selectionRange.lowerBound, offsetBy: textEditorModel.clipboard.count)
        textEditorModel.textSelection = newIndex..<newIndex
    }
}

