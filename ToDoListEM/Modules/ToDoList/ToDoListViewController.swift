//
//  ViewController.swift
//  ToDoListEM
//
//  Created by Сергей on 18.08.2025.
//

import UIKit

class ToDoListViewController: UIViewController, TodoListViewProtocol {
  
  var presenter: ToDoListPresenterProtocol?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    presenter?.viewDidLoad()
    view.backgroundColor = .red
  }


}

