import Foundation
import CoreData

final class AddEditInteractor: AddEditInteractorInput {
  private let core = CoreDataManager.shared
  private let existing: ToDo?
  
  init(existing: ToDo?) {
    self.existing = existing
  }
  
  func saveNew(title: String, details: String?) {
    let cd = CDTodo(context: core.context)
    cd.id = Int64(Date().timeIntervalSince1970)
    cd.title = title
    cd.details = details
    cd.createdAt = Date()
    cd.isCompleted = false
    core.saveContext()
  }
  
  func updateExisting(_ todo: ToDo, title: String, details: String?) {
    let request: NSFetchRequest<CDTodo> = CDTodo.fetchRequest()
    request.predicate = NSPredicate(format: "id == %lld", todo.id)
    request.fetchLimit = 1
    do {
      if let cd = try core.context.fetch(request).first {
        cd.title = title
        cd.details = details
        core.saveContext()
      }
    } catch {
      print("Update error: \(error)")
    }
  }
  
  func fetchAll() -> [ToDo] {
    let request: NSFetchRequest<CDTodo> = CDTodo.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
    do {
      return try core.context.fetch(request).compactMap(ToDo.init(cd:))
    } catch {
      print("Fetch all error: \(error)")
      return []
    }
  }
}
