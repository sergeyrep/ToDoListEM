import Foundation
import UIKit

protocol ToDoListViewProtocol: AnyObject {
  func show(todos: [ToDo])
  func reloadRow(at index: Int)
  func viewDidLoad()
  func didTapAdd()
  func didSelectRow(at index: Int)
  func didToggleDone(at index: Int)
  func didSearch(text: String)
}

protocol ToDoListInteractorProtocol: AnyObject {
  func fetchTodos() -> [ToDo]
  func toggleDone(id: Int64)
}

protocol ToDoListRouterProtocol: AnyObject {
  func openAddEdit(from view: UIViewController, todo: ToDo?, output: AddEditModuleOutput?)
}


