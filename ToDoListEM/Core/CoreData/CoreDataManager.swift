import CoreData

/// Одиночка для работы с CoreData
final class CoreDataManager {
  static let shared = CoreDataManager()

  private let container: NSPersistentContainer
  var context: NSManagedObjectContext { container.viewContext }

  private init() {
    container = NSPersistentContainer(name: "ToDoModel")
    container.loadPersistentStores { _, error in
      if let error = error { fatalError("CoreData load error: \(error)") }
    }
    // Удобно — автоматическое слияние изменений из бэкграунда в viewContext
    context.automaticallyMergesChangesFromParent = true
  }

  func saveContext() {
    guard context.hasChanges else { return }
    do {
      try context.save()
    } catch {
      print("CoreData save error: \(error)")
    }
  }
}


