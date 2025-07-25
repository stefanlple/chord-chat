protocol WebSocketListener : Hashable {
    mutating func update(with: Message)
}
