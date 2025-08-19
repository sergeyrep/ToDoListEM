import Foundation

final class ToDoListInteractor: TodoListInteractorProtocol {
  
  weak var presenter: ToDoListPresenterProtocol?
  private let networkService: NetworkServiseProtocol
  
  init(networkService: NetworkServiseProtocol) {
    self.networkService = networkService
  }

  func fetchData() async throws -> [ToDo] {
    try await networkService.fetchTodos()
  }
}
