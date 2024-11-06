import Foundation
import CoreData


extension Height {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Height> {
        return NSFetchRequest<Height>(entityName: "Height")
    }

    @NSManaged public var height: String

}

extension Height : Identifiable {

}
