import Foundation

protocol TodoListViewProtocol: AnyObject {
  func reloadData()
  func reloadRow(at index: Int)
//  func show(todos: [Todo])
//  func showLoading(_ isLoading: Bool)
//  func showError(_ message: String)
}

protocol TodoListInteractorProtocol: AnyObject {
//  func loadInitialData() async
  func fetchData() async throws -> [ToDo]
  
//  func save(todo: Todo) async
//  func delete(id: Int64) async
//  func search(query: String) async
}

protocol TodoListRouterProtocol: AnyObject {
//  func showAdd(from: TodoListViewInput)
//  func showEdit(todo: Todo, from: TodoListViewInput)
  func presentAddTask() 
}

protocol ToDoListPresenterProtocol: AnyObject {
  var items: [ToDo]? { get }
  var filteredItems: [ToDo] { get }
  var isSearching: Bool { get set }
  func filterContentForSearchText(_ searchText: String)
  func searchDidCancel()
  func viewDidLoad()
  func didTapAddButton()
  func toggleCompletion(for id: Int)
  
}


