import SwiftUI

struct ChordChatView: View {
    @ObservedObject var viewModel = ChatViewModel()
    @State private var messages: [Message] = [
        Message(messageType: MessageType.message, senderName: "Michael B", timeStamp: TimeStampUtil.getDateNowMiliseconds(), message: "hallo"),
            Message(messageType: MessageType.message, senderName: "TaylorSwifty", timeStamp: "1753442054.317661", message: "hallo1"),
            Message(messageType: MessageType.message, senderName: "TaylorSwifty", timeStamp: "1753442054.317661", message: "hallo2"),
            Message(messageType: MessageType.message, senderName: "TaylorSwifty", timeStamp: "1753442054.317661", message: "hallo3"),
            Message(messageType: MessageType.message, senderName: "TaylorSwifty", timeStamp: "1753442054.317661", message: "hallo4"),
            Message(messageType: MessageType.message, senderName: "TaylorSwifty", timeStamp: "1753442054.317661", message: "hallo5"),
            Message(messageType: MessageType.message, senderName: "TaylorSwifty", timeStamp: "1753442054.317661", message: "hall6"),
            Message(messageType: MessageType.message, senderName: "TaylorSwifty", timeStamp: "1753442054.317661", message: "hallo7"),
            Message(messageType: MessageType.message, senderName: "TaylorSwifty", timeStamp: "1753442054.317661", message: "hallo8"),
            Message(messageType: MessageType.message, senderName: "TaylorSwifty", timeStamp: "1753442054.317661", message: "hallo9")
        ]
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Chord")
            ScrollViewReader { proxy in
                List{
                    ForEach(messages){ message in
                        MessageView(senderName: message.senderName, timeStamp: message.timeStamp, message: message.message, currentSenderName: viewModel.currentSenderName).id(message.id)
                    }
                }.onChange(of: messages.count) { _, _ in
                    if let lastID = messages.last?.id {
                        withAnimation{
                            proxy.scrollTo(lastID, anchor: .bottom)
                        }
                    }
                }
            }
            
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
                /*messages.insert(Message(messageType: MessageType.message, senderName: "TaylorSwifty", timeStamp: "12342.317661", message: "hallo"), at: messages.count)*/
//                viewModel.send()
            }

            SwiftUI.TextEditor(text: $viewModel.text, selection: $viewModel.selection)
        }.padding()
    }
}

struct MessageView : View {
    let senderName: String
    let timeStamp: String
    let message: String
    let currentSenderName: String
    
    
    
    var body: some View {
        let paddedPrefix = senderName.padding(toLength: 10, withPad: " ", startingAt: 0)
        
        guard let timeStampDate = TimeStampUtil.convertTimestampIntoDate(timestamp: timeStamp) else {
            return Text("Invalid message")
        }
        
        let senderNameView = Text(paddedPrefix).bold().foregroundStyle(currentSenderName == senderName ? .red : .white)
        return senderNameView +
               Text(" - ").bold() +
               Text(timeStampDate.localizedDescription).bold() +
               Text(": \(message)")
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
