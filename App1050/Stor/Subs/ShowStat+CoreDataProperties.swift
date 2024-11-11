import Foundation
import CoreData


extension ShowStat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShowStat> {
        return NSFetchRequest<ShowStat>(entityName: "ShowStat")
    }

    @NSManaged public var show: Bool

}

extension ShowStat : Identifiable {

}
