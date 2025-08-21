import Foundation
import CoreData

final class ToDoListInteractor: ToDoListInteractorProtocol {
  // Только CoreData в этом примере
  private let core = CoreDataManager.shared
  
  func fetchTodos() -> [ToDo] {
    let request: NSFetchRequest<CDTodo> = CDTodo.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
    do {
      let result = try core.context.fetch(request)
      return result.compactMap(ToDo.init(cd:))
    } catch {
      print("Fetch error: \(error)")
      return []
    }
  }
  
  func toggleDone(id: Int64) {
    let request: NSFetchRequest<CDTodo> = CDTodo.fetchRequest()
    request.predicate = NSPredicate(format: "id == %lld", id)
    request.fetchLimit = 1
    do {
      if let cd = try core.context.fetch(request).first {
        cd.isCompleted.toggle()
        core.saveContext()
      }
    } catch {
      print("Toggle error: \(error)")
    }
  }
}
