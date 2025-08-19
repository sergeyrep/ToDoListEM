import Foundation

protocol AddEditConfiguratorProtocol: AnyObject {
  
}

protocol AddEditPresenterProtocol: AnyObject {
  var item: ToDo { get }
  func saveTask()
}

protocol AddEditInteractorProtocol: AnyObject {
  func fetchDataOne() async throws -> ToDo
  
}

protocol AddEditViewControllerProtocol: AnyObject {
  
}
