protocol TextEditorCommand {
//    var app
//    var editor
// backup
    var mutating : Bool { get }

    func execute()
}
