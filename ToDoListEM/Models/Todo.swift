import Foundation

struct ToDo: Identifiable, Equatable {
  let id: Int
  var title: String
  var details: String?
  var createdAt: Date
  var isCompleted: Bool
}

