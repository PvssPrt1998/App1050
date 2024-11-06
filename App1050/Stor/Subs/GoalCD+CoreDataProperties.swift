import Foundation
import CoreData


extension GoalCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GoalCD> {
        return NSFetchRequest<GoalCD>(entityName: "GoalCD")
    }

    @NSManaged public var uuid: UUID
    @NSManaged public var state: Int32
    @NSManaged public var value: Int32
    @NSManaged public var date: String

}

extension GoalCD : Identifiable {

}
