import Foundation

final class ToDoListPresenter: ToDoListPresenterProtocol {
  
  var items: [ToDo] = []
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
        let items = try await interactor.fetchData() //????
        self.items = items
        view?.reloadData()
      } catch {
        print(error)
      }
    }
  }
  
  func didTapAddButton() {
   // router.presentAddTask()
  }
}
