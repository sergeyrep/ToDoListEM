import Foundation
import UIKit

// MARK: - View
protocol AddEditViewInput: AnyObject {
  func fill(with todo: ToDo?)
  func close()
}

protocol AddEditViewOutput: AnyObject {
  func viewDidLoad()
  func save(title: String, details: String?)
}

// MARK: - Interactor
protocol AddEditInteractorInput: AnyObject {
  func saveNew(title: String, details: String?)
  func updateExisting(_ todo: ToDo, title: String, details: String?)
  func fetchAll() -> [ToDo]
}

protocol AddEditRouterInput: AnyObject { }

protocol AddEditModuleOutput: AnyObject {
  func addEditDidFinish(_ updatedList: [ToDo])
}
