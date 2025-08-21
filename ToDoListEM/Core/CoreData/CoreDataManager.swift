import Foundation
import CoreData

final class CoreDataManager {
  static let shared = CoreDataManager()
  
  let persistentContainer: NSPersistentContainer
  
  var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  private init() {
    persistentContainer = NSPersistentContainer(name: "ToDoModel")
    persistentContainer.loadPersistentStores { _, error in
      if let error = error {
        fatalError("Error load CoreData: \(error)")
      }
    }
  }
  
  func save() {
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        print("Error save CoreData: \(error)")
      }
    }
  }
}
