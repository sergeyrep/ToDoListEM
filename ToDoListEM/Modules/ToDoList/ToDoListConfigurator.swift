import UIKit

final class ToDoListRouter: ToDoListRouterProtocol {
  static func createModule() -> UIViewController {
    let view = ToDoListViewController()
    let interactor = ToDoListInteractor()
    let router = ToDoListRouter()
    let presenter = ToDoListPresenter(view: view, interactor: interactor, router: router)
    view.output = presenter
    return view
  }

  func openAddEdit(from view: UIViewController, todo: ToDo?, output: AddEditModuleOutput?) {
    let addEditVC = AddEditRouter.build(todo: todo, output: output)
    view.navigationController?.pushViewController(addEditVC, animated: true)
  }
}
