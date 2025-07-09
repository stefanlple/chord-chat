protocol TextEditorCommand<ChatContent> {
    associatedtype ChatContent
    var textEditor: EditorText { get }
    var backUpState: ChatContent { get set }
    var mutatingCommand : Bool { get }
    
    init(_ textEditor: EditorText)
    
    func execute()
}
