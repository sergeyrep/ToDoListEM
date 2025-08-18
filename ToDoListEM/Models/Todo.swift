import Foundation

struct Todo: Identifiable, Equatable {
  let id: Int
  var title: String
  var details: String?
  var createdAt: Date
  var isCompleted: Bool
}

