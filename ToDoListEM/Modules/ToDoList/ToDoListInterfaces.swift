//
//  ToDoListInterfaces.swift
//  ToDoListEM
//
//  Created by Сергей on 18.08.2025.
//
import Foundation

protocol TodoListViewProtocol: AnyObject {
//  func show(todos: [Todo])
//  func showLoading(_ isLoading: Bool)
//  func showError(_ message: String)
}

protocol TodoListInteractorProtocol: AnyObject {
//  func loadInitialData() async
  func fetchData() async throws -> [Todo]
//  func save(todo: Todo) async
//  func delete(id: Int64) async
//  func search(query: String) async
}

protocol TodoListRouterProtocol: AnyObject {
//  func showAdd(from: TodoListViewInput)
//  func showEdit(todo: Todo, from: TodoListViewInput)
}

protocol ToDoListPresenterProtocol: AnyObject {
  func viewDidLoad()
  
}


