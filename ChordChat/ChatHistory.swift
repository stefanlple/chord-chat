import Foundation

struct ChatHistory {
    typealias TextCommandArray = [TextCommand]

    var historyStack = TextCommandArray()
    var historyPointer = 0

    mutating func getNextHistory() -> TextCommand {
        incrementPointer()
        return historyStack[historyPointer]
    }

    mutating func getPreviousHistory() -> TextCommand {
        decrementPointer()
        print("Hisotry Pointer", historyPointer)
        return historyStack[historyPointer]
    }

    mutating func pushToHistory(_ element: TextCommand) {
        historyStack.append(element)
        incrementPointer()
    }

    mutating func removeHistoryRange(startIndex: Int, endIndex: Int? = nil) -> TextCommandArray {
        historyStack.removeSubrange(startIndex..<(endIndex ?? historyStack.count - 1))
        return historyStack
    }

    private mutating func incrementPointer() {
        guard historyPointer < historyStack.count - 1 else {
            return
        }
        historyPointer += 1
    }

    private mutating func decrementPointer() {
        guard historyPointer > 0 else {
            return
        }
        historyPointer -= 1
    }
}
