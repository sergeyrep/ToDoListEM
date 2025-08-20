import Foundation

final class ToDoListPresenter: ToDoListPresenterProtocol {
  
  private(set) var filteredItems: [ToDo] = []
  var isSearching: Bool = false
  var items: [ToDo]? = []
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
        let items = try await interactor.fetchData()
        self.items = items
        view?.reloadData()
      } catch {
        print(error)
      }
    }
  }
  
  func filterContentForSearchText(_ searchText: String) {
    guard let items = items else {
      filteredItems = []
      view?.reloadData()
      return
    }
    
    filteredItems = items.filter { item in
      return item.title.lowercased().contains(searchText.lowercased()) ||
      (item.details?.lowercased().contains(searchText.lowercased()) ?? false)
    }
    
    isSearching = !searchText.isEmpty
    view?.reloadData()
  }
  
  func searchDidCancel() {
    isSearching = false
    filteredItems = []
    view?.reloadData()
  }
  
  func toggleCompletion(for id: Int) {
    // Находим задачу и меняем ее статус
    if let index = items?.firstIndex(where: { $0.id == id }) {
      items?[index].isCompleted.toggle()
      view?.reloadRow(at: index) //новый метод, добавил ат индекс
      
      // Здесь можно сохранить изменения в базу данных
    }
  }
  
  func didTapAddButton() {
    // router.presentAddTask()
  }
}


//private func filterContentForSearchText(_ searchText: String) {
//  guard let items = presenter?.items else { return }
//
//  filteredItems = items.filter { item in
//    return item.title.lowercased().contains(searchText.lowercased()) ||
//    (item.details?.lowercased().contains(searchText.lowercased()) ?? false)
//  }
//  tableView.reloadData()
//}
