struct MessageHandler: WebSocketHandler {
    let updateClosure: (Message) -> Void

    func handle(message: Message) {
        updateClosure(message)
    }
}
