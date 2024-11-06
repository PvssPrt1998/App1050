import Foundation
import CoreData


extension Birthday {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Birthday> {
        return NSFetchRequest<Birthday>(entityName: "Birthday")
    }

    @NSManaged public var birthday: String

}

extension Birthday : Identifiable {

}
