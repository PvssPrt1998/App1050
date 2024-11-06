import Foundation
import CoreData


extension Weight {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weight> {
        return NSFetchRequest<Weight>(entityName: "Weight")
    }

    @NSManaged public var weight: String

}

extension Weight : Identifiable {

}
