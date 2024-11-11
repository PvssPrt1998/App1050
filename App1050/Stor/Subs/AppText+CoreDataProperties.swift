import Foundation
import CoreData


extension AppText {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppText> {
        return NSFetchRequest<AppText>(entityName: "AppText")
    }

    @NSManaged public var text: String

}

extension AppText : Identifiable {

}
