import SwiftUI

struct TextEditorModel {
    var text: String
    var oldText: String
    
    var clipboard: String
    var selection: Range<Int>
    
    var isUndoing = false
    var isRedoing = false
    
    
    func getText(){
        
    }
}

