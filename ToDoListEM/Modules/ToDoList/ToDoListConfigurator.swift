import UIKit

final class ToDoListConfigurator: TodoListRouterProtocol {
  
  weak var viewController: UIViewController?
  
  func configure() -> UIViewController {
    let view = ToDoListViewController()
    let networkServise = NetworkServise()
    let interactor = ToDoListInteractor(networkService: networkServise)
    //let router = ToDoListConfigurator()
    let presenter = ToDoListPresenter(
      view: view,
      interactor: interactor,
      //router: ToDoListConfigurator()
    )
    
    view.presenter = presenter
    interactor.presenter = presenter
    presenter.view = view
    //router.viewController = view
    
    return view
  }
  
  func presentAddTask() {
    
  }
}
