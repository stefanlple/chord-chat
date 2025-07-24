import SwiftUI

struct ChordChatView: View {
    @ObservedObject var viewModel = ChatViewModel()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)

            Text("Chord")

            HStack {
                // mutating action
                ButtonComponent(content: "Undo", icon: "arrowshape.turn.up.backward.circle") {
                    print("Undo")
                    viewModel.undo()
                }.keyboardShortcut("z", modifiers: [.command])

                // mutating action
                ButtonComponent(content: "Redo", icon: "arrowshape.turn.up.forward.circle") {
                    print("Redo")
                    viewModel.redo()
                }.keyboardShortcut("z", modifiers: [.command, .shift])

                // non mutating action
                ButtonComponent(content: "Select All", icon: "doc.on.doc") {
                    print("Select All")
                    viewModel.selectAll()
                }.keyboardShortcut("a", modifiers: [.command])

                // non mutating action
                ButtonComponent(content: "Copy", icon: "clipboard") {
                    print("Copy")
                    viewModel.copy()
                }.keyboardShortcut("c", modifiers: [.command])

                // mutating action
                ButtonComponent(content: "Paste", icon: "doc.on.clipboard") {
                    print("Paste")
                    viewModel.paste()
                }.keyboardShortcut("v", modifiers: [.command])

                // mutating action
                ButtonComponent(content: "Cut", icon: "scissors") {
                    print("Cut")
                    viewModel.cut()
                }.keyboardShortcut("x", modifiers: [.command])
            }

            ButtonComponent(content: "Send", icon: "paperplane") {
                print("Send")
                viewModel.send()
            }

            SwiftUI.TextEditor(text: $viewModel.text, selection: $viewModel.selection)
        }.padding()
    }
}

struct ButtonComponent: View {
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
    ChordChatView()
}
