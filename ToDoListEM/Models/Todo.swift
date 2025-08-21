import Foundation

/// Домашняя модель (не CoreData), удобна для презентеров/вью
struct ToDo: Identifiable, Equatable {
  let id: Int64
  var title: String
  var details: String?
  var createdAt: Date
  var isCompleted: Bool
}

/// Маппинги между CoreData и доменной моделью
extension ToDo {
  init?(cd: CDTodo) {
    guard cd.details != nil else { return nil }
    self.id = cd.id
    self.title = cd.title
    self.details = cd.details
    self.createdAt = cd.createdAt
    self.isCompleted = cd.isCompleted
  }
}

extension CDTodo {
  func update(with todo: ToDo) {
    id = todo.id
    title = todo.title
    details = todo.details
    createdAt = todo.createdAt
    isCompleted = todo.isCompleted
  }
}
