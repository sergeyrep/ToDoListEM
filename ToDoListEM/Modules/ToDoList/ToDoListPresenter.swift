import Foundation
import UIKit

final class ToDoListPresenter: ToDoListViewProtocol, AddEditModuleOutput {
  
  private weak var view: ToDoListViewProtocol?
  private let interactor: ToDoListInteractorProtocol
  private let router: ToDoListRouterProtocol
  
  private var all: [ToDo] = []
  private var filtered: [ToDo] = []
  private var isSearching = false
  
  init(view: ToDoListViewProtocol,
       interactor: ToDoListInteractorProtocol,
       router: ToDoListRouterProtocol) {
    self.view = view
    self.interactor = interactor
    self.router = router
  }
  
  func viewDidLoad() {
    all = interactor.fetchTodos()
    view?.show(todos: all)
  }
  
  func didTapAdd() {
    guard let vc = view as? UIViewController else { return }
    router.openAddEdit(from: vc, todo: nil, output: self)
  }
  
  func didSelectRow(at index: Int) {
    let current = isSearching ? filtered[index] : all[index]
    guard let vc = view as? UIViewController else { return }
    router.openAddEdit(from: vc, todo: current, output: self)
  }
  
  func didToggleDone(at index: Int) {
    let todo = isSearching ? filtered[index] : all[index]
    interactor.toggleDone(id: todo.id)
    // Перечитываем список из БД — так проще и надежнее
    all = interactor.fetchTodos()
    if isSearching {
      applyFilter(text: nil) // обновит filtered
    }
    view?.show(todos: isSearching ? filtered : all)
    view?.reloadRow(at: index)
  }
  
  func didSearch(text: String) {
    isSearching = !text.isEmpty
    if isSearching { applyFilter(text: text) }
    view?.show(todos: isSearching ? filtered : all)
  }
  
  private func applyFilter(text: String?) {
    let q = (text ?? "").lowercased()
    filtered = all.filter {
      $0.title.lowercased().contains(q) ||
      ($0.details?.lowercased().contains(q) ?? false)
    }
  }
  
  func addEditDidFinish(_ updatedList: [ToDo]) {
    // Получили новые данные из Add/Edit
    self.all = updatedList
    if isSearching { applyFilter(text: nil) }
    view?.show(todos: isSearching ? filtered : all)
  }
  
  func show(todos: [ToDo]) {}
  
  func reloadRow(at index: Int) {}
}
