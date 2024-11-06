import Foundation

struct Goal: Hashable, NoteAndGoal {
    let uuid: UUID
    var state: Int
    var value: Int
    var date: String
}
