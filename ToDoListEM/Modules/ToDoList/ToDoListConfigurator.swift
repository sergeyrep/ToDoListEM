//
//  ToDoListConfiguration.swift
//  ToDoListEM
//
//  Created by Сергей on 18.08.2025.
//

import UIKit

final class ToDoListConfigurator {
  
  func configure() -> UIViewController {
    let view = ToDoListViewController()
    let networkServise = NetworkServise()
    let interactor = ToDoListInteractor(networkService: networkServise)
    let presenter = ToDoListPresenter(
      view: view,
      interactor: interactor
    )
    
    view.presenter = presenter
    interactor.presenter = presenter
    
    return view
  }
}
