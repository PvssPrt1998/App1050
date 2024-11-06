import Foundation
import CoreData


extension NoteCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteCD> {
        return NSFetchRequest<NoteCD>(entityName: "NoteCD")
    }

    @NSManaged public var uuid: UUID
    @NSManaged public var state: Int32
    @NSManaged public var title: Int32
    @NSManaged public var date: String

}

extension NoteCD : Identifiable {

}
