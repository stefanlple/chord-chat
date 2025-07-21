import Foundation

struct ChatHistory {
    typealias TextCommandArray = [TextCommand]

    var historyStack = TextCommandArray()
    var historyPointer = 0

    mutating func getNextHistory() throws -> TextCommand?  {
        guard historyPointer < historyStack.count - 1 else {
            throw ChatHistoryError.pointerOutOfBound
        }
        historyPointer += 1
        return historyStack[historyPointer]
    }

    mutating func getPreviousHistory() throws -> TextCommand {
        guard historyPointer > 0 else {
            throw ChatHistoryError.pointerOutOfBound
        }
        historyPointer -= 1
        return historyStack[historyPointer]
    }

    mutating func pushToHistory(_ element: TextCommand) throws {
        historyStack.append(element)
        try incrementPointer()
    }

    mutating func removeHistoryRange(startIndex: Int, endIndex: Int? = nil) -> TextCommandArray {
        historyStack.removeSubrange(startIndex..<(endIndex ?? historyStack.count))
        return historyStack
    }

    private mutating func incrementPointer() throws {
        guard historyPointer < historyStack.count - 1 else {
            throw ChatHistoryError.pointerOutOfBound
        }
        historyPointer += 1
    }

    private mutating func decrementPointer() throws {
        guard historyPointer > 0 else {
            throw ChatHistoryError.pointerOutOfBound
        }
        historyPointer -= 1
    }
}
