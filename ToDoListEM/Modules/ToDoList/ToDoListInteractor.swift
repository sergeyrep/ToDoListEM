//
//  ToDoListInteractor.swift
//  ToDoListEM
//
//  Created by Сергей on 18.08.2025.
//

import Foundation

final class ToDoListInteractor: TodoListInteractorProtocol {
  
  weak var presenter: ToDoListPresenterProtocol?
  private let networkService: NetworkServiseProtocol
  
  init(networkService: NetworkServiseProtocol) {
    self.networkService = networkService
  }

  func fetchData() async throws -> [Todo] {
    try await networkService.fetchTodos()
  }
}
