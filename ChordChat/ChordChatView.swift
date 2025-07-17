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
//                    viewModel.updateText(newText: )
                }
                
                // mutating action
                ButtonComponent(content: "Redo", icon: "arrowshape.turn.up.forward.circle") {
                    print("Redo")
                    viewModel.redo()
                }
                
                
                // non mutating action
                ButtonComponent(content: "Select All", icon: "doc.on.doc") {
                    print("Select All")
                }
                
                // non mutating action
                ButtonComponent(content: "Copy", icon: "clipboard") {
                    print("Copy")
                }
                
                // mutating action
                ButtonComponent(content: "Paste", icon: "doc.on.clipboard") {
                    print("Paste")
                }
                
                // mutating action
                ButtonComponent(content: "Cut", icon: "scissors") {
                    print("Cut")
                    }
                }
                
                ButtonComponent(content: "Send", icon: "paperplane") {
                    print("Send")
                }
            

//            SwiftUI.TextEditor(text: $viewModel.text, selection: $viewModel.selection)
            SwiftUI.TextEditor(text: $viewModel.text)
//                .onChange(of: text) {
//                    oldValue, newValue in
//                    viewModel.inser
//                }
//                .onAppear{
//                }
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
