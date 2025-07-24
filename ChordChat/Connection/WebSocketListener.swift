protocol WebSocketListener : Hashable {
    func update(with: Message)
}
