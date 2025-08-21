import UIKit

final class AddEditConfigurator: AddEditConfiguratorProtocol {
  
  
  
  func configure(with todo: ToDo) -> UIViewController {
    let view = AddEditViewController()
    let networkServise = NetworkServise()
    let interactor = AAddEditInteractor(networkServise: networkServise)
    let presenter = AddEditPresenter(
      view: view,
      item: todo,
      interactor: interactor
    )
        
    view.presenter = presenter
    presenter.view = view
    presenter.interactor = interactor
    interactor.presenter = presenter
    
      
    return view
  }
}

