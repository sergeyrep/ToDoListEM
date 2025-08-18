//
//  ToDoListPresenter.swift
//  ToDoListEM
//
//  Created by Сергей on 18.08.2025.
//

import Foundation

final class ToDoListPresenter: ToDoListPresenterProtocol {
  
  weak var view: TodoListViewProtocol?
  var interactor: TodoListInteractorProtocol
  //var router: TodoListRouterProtocol
  
  init(
    view: TodoListViewProtocol?,
    interactor: TodoListInteractorProtocol
    //router: TodoListRouterProtocol
  ) {
    self.view = view
    self.interactor = interactor
    //self.router = router
  }
  
  func viewDidLoad() {
    Task {
      do {
        let items = try await interactor.fetchData()
        print("auff")
      } catch {
        print(error)
      }
    }
  }
}
