import Foundation

struct Note: Hashable, NoteAndGoal {
    
    let uuid: UUID
    
    var state: Int
    var title: Int
    var date: String
}
