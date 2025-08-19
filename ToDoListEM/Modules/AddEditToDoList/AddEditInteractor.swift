import Foundation

final class AAddEditInteractor: AddEditInteractorProtocol {
 
  weak var presenter: AddEditPresenterProtocol?
  private let networkServise: NetworkServiseProtocol
  
  init(networkServise: NetworkServiseProtocol) {
    self.networkServise = networkServise
  }
  
  func fetchDataOne() async throws -> ToDo {
    let todo = try await networkServise.fetchTodo(id: 1)
    print(todo.title)
    return todo
  }
}
