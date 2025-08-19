import UIKit

final class AddEditPresenter: AddEditPresenterProtocol {
  
  weak var view: AddEditViewControllerProtocol?
  var item: ToDo
  var interactor: AddEditInteractorProtocol
  
  init(view: AddEditViewControllerProtocol?,
       item: ToDo,
       interactor: AddEditInteractorProtocol) {
    self.view = view
    self.item = item
    self.interactor = interactor
  }
  
  func saveTask() {
    
  }
}
