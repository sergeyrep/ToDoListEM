import Foundation

final class AddEditPresenter: AddEditViewOutput {
  private weak var view: AddEditViewInput?
  private let interactor: AddEditInteractorInput
  private let router: AddEditRouterInput
  private weak var output: AddEditModuleOutput?
  private let editingTodo: ToDo?
  
  init(view: AddEditViewInput,
       interactor: AddEditInteractorInput,
       router: AddEditRouterInput,
       output: AddEditModuleOutput?,
       editingTodo: ToDo?) {
    self.view = view
    self.interactor = interactor
    self.router = router
    self.output = output
    self.editingTodo = editingTodo
  }
  
  func viewDidLoad() {
    view?.fill(with: editingTodo)
  }
  
  func save(title: String, details: String?) {
    if let todo = editingTodo {
      interactor.updateExisting(todo, title: title, details: details)
    } else {
      interactor.saveNew(title: title, details: details)
    }
    // Сообщаем списку, что данные обновились
    output?.addEditDidFinish(interactor.fetchAll())
    view?.close()
  }
}
