import UIKit

final class AddEditRouter: AddEditRouterInput {

  static func build(todo: ToDo?,
                    output: AddEditModuleOutput?) -> UIViewController {
    let view = AddEditViewController()
    let interactor = AddEditInteractor(existing: todo)
    let router = AddEditRouter()
    let presenter = AddEditPresenter(
      view: view,
      interactor: interactor,
      router: router,
      output: output,
      editingTodo: todo
    )
    view.output = presenter
    return view
  }
}
