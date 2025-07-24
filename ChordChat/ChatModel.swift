struct ChatModel : WebSocketListener {
    var textEditor: TextEditorModel
    let webSocketManager: WebSocketManager
    let webSocketUrl: String
    let senderName: String
    var messageFactory: MessageFactory
    
    init(webSocketUrl: String, senderName: String = "Default Name") {
        textEditor = TextEditorModel()
        webSocketManager = WebSocketManager.singleton
        self.webSocketUrl = webSocketUrl
        webSocketManager.connect(to: webSocketUrl)
        self.senderName = senderName
        
        messageFactory = MessageFactory(senderInfo: senderName)
        
        webSocketManager.registerListener(listener: self)
        webSocketManager.registerHandlers(messageType: MessageType.message, handler: MessageHandler())
    }

    public var text: String {
        textEditor.text
    }

    public var textSelection: Range<String.Index> {
        textEditor.textEditorState.textSelection
    }

    public mutating func updateText(
        newText: String,
        textSelection: Range<String.Index>
    ) {
        var updateCommand: any TextCommand = UpdateTextCommand(
            newText: newText,
            textSelection: textSelection
        )
        textEditor.execute(textCommand: &updateCommand)
    }

    public mutating func undo() {
        var undoCommand: any TextCommand = UndoCommand()
        textEditor.execute(textCommand: &undoCommand)
    }

    public mutating func redo() {
        var redoCommand: any TextCommand = RedoCommand()
        textEditor.execute(textCommand: &redoCommand)
    }
    
    public mutating func selectAll() {
        var selectAllCommand : any TextCommand = SelectAllCommand()
        textEditor.execute(textCommand: &selectAllCommand)
    }
    
    public mutating func copy() {
        var copyCommand : any TextCommand = CopyCommand()
        textEditor.execute(textCommand: &copyCommand)
    }
    
    public mutating func paste() {
        var pasteCommand : any TextCommand = PasteCommand()
        textEditor.execute(textCommand: &pasteCommand)
    }
    
    public mutating func cut() {
        var cutCommand : any TextCommand = CutCommand()
        textEditor.execute(textCommand: &cutCommand)
    }
    
    public mutating func send() {
        var sendCommand: any TextCommand = SendCommand(senderName: senderName, messageFactory: messageFactory)
        textEditor.execute(textCommand: &sendCommand)
    }
    
    public func update(with: Message) {
        
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(webSocketUrl)
            hasher.combine(senderName)
        }
        
    static func == (lhs: ChatModel, rhs: ChatModel) -> Bool {
        return lhs.webSocketUrl == rhs.webSocketUrl &&
               lhs.senderName == rhs.senderName
    }
}
