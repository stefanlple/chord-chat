import Foundation

struct ChatMananger<ChatContent> {
    var historyStack = [ChatContent]()
    var historyPointer = 0
    
    mutating func getNextHistory() -> ChatContent {
        incrementPointer()
        return historyStack[historyPointer]
    }
    
    mutating func getPreviousHistory() -> ChatContent {
        decrementPointer()
        return historyStack[historyPointer]
    }
    
    
    mutating func pushToHistory(_ element: ChatContent){
        historyStack.append(element)
    }
    
    mutating func removeHistoryRange(starIndex: Int, endIndex: Int? = nil){
        historyStack.removeSubrange(starIndex..<(endIndex ?? historyStack.count - 1))
    }
    
    private mutating func incrementPointer(){
        historyPointer+=1
    }
    
    private mutating func decrementPointer(){
        historyPointer-=1
    }
}
