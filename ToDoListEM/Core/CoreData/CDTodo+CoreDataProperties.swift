import Foundation
import CoreData

extension CDTodo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTodo> {
        return NSFetchRequest<CDTodo>(entityName: "CDTodo")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String
    @NSManaged public var details: String?
    @NSManaged public var createdAt: Date
    @NSManaged public var isCompleted: Bool

}

extension CDTodo : Identifiable {

}
