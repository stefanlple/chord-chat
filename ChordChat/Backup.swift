import SwiftUI

struct Backup: View {
    @State private var text = ""
    @State var selection: TextSelection? = nil
    @State private var previousText = ""
    @State private var isUndoing = false
    @State private var isRedoing = false

    @State private var clipboard = ""

    @State var historyStack = [String]()
    @State var historyPointer = 0

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)

            Text("Chord")

            HStack {
                // mutating action
                HalloTestBackUpButtonComponent(
                    content: "Undo", icon: "arrowshape.turn.up.backward.circle"
                ) {
                    print("Undo")
                    if historyPointer > 0 {
                        isUndoing = true
                        historyPointer -= 1
                        let element = historyStack[historyPointer]
                        text = element
                        selection = nil
                    }
                }

                // mutating action
                HalloTestBackUpButtonComponent(
                    content: "Redo", icon: "arrowshape.turn.up.forward.circle"
                ) {
                    print("Redo")
                    if historyPointer < historyStack.count - 1 {
                        isRedoing = true
                        historyPointer += 1
                        let element = historyStack[historyPointer]
                        text = element
                        selection = nil
                    }
                }

                // non mutating action
                HalloTestBackUpButtonComponent(content: "Select All", icon: "doc.on.doc") {
                    print("Select All")
                    selection?.indices = .selection(text.startIndex..<text.endIndex)
                }

                // non mutating action
                HalloTestBackUpButtonComponent(content: "Copy", icon: "clipboard") {
                    print("Copy")
                    guard let selection else {
                        return
                    }
                    if case let .selection(range) = selection.indices {
                        clipboard = String(text[range])
                    }
                }

                // mutating action
                HalloTestBackUpButtonComponent(content: "Paste", icon: "doc.on.clipboard") {
                    print("Paste")
                    guard let selection else {
                        return
                    }

                    if case let .selection(range) = selection.indices {
                        text.removeSubrange(range)
                        text.insert(contentsOf: clipboard, at: range.lowerBound)
                        let newIndex = text.index(range.lowerBound, offsetBy: clipboard.count)
                        self.selection?.indices = .selection(newIndex..<newIndex)
                    }
                }

                // mutating action
                HalloTestBackUpButtonComponent(content: "Cut", icon: "scissors") {
                    print("Cut")
                    guard let selection else {
                        return
                    }

                    if case let .selection(range) = selection.indices {
                        clipboard = String(text[range])
                        text.removeSubrange(range)
                        let newIndex = text.index(range.lowerBound, offsetBy: 0)
                        self.selection?.indices = .selection(newIndex..<newIndex)
                    }
                }

                HalloTestBackUpButtonComponent(content: "Send", icon: "paperplane") {
                    print("Send")
                }
            }

            SwiftUI.TextEditor(text: $text, selection: $selection)
                .onChange(of: text) {
                    oldValue, newValue in
                    if isUndoing {
                        isUndoing = false
                    } else if isRedoing {
                        isRedoing = false
                    } else {
                        historyStack.removeSubrange(historyPointer..<historyStack.count)
                        historyStack.append(oldValue)
                        historyPointer += 1
                    }
                }
                .onAppear {
                    historyStack = [text]
                    historyPointer = 0
                }
        }
        .padding()
    }
}

struct HalloTestBackUpButtonComponent: View {
    var content: String
    var icon: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                Text(content)
            }
        }
    }
}

#Preview {
    Backup()
}
