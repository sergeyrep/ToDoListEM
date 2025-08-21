import UIKit
import CoreData

class ToDoListViewController: UIViewController, TodoListViewProtocol {
  
  private lazy var addButton = UIBarButtonItem(
    barButtonSystemItem: .add,
    target: self,
    action: #selector(addButtonTapped)
  )

  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.separatorColor = .darkGray
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  private let searchController = UISearchController(searchResultsController: nil)
  
  var presenter: ToDoListPresenterProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    updateSearchResults()
    presenter?.viewDidLoad()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    searchController.isActive = false
  }
  
  func reloadRow(at index: Int) {
    DispatchQueue.main.async {
      let indexPath = IndexPath(row: index, section: 0)
      self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
  }
  
  func reloadData() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
  private func updateSearchResults() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Поиск"
    searchController.searchBar.tintColor = .systemBlue
    //searchController.searchBar.delegate = self
    
    searchController.searchBar.barTintColor = .black
    searchController.searchBar.backgroundColor = .black
    
    if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
      textField.textColor = .white
      textField.backgroundColor = .darkGray
      textField.attributedPlaceholder = NSAttributedString(
        string: "Поиск",
        attributes: [.foregroundColor: UIColor.lightGray]
      )
    }
    
    searchController.searchBar.delegate = self
    
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    definesPresentationContext = true
  }
  
  private func setupUI() {
    view.backgroundColor = .black
    
    navigationItem.backButtonTitle = "Назад"
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .black
    appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    
    let backButtonAppearance = UIBarButtonItemAppearance()
    backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.systemYellow]
    appearance.backButtonAppearance = backButtonAppearance
    
    navigationController?.navigationBar.standardAppearance = appearance
    //navigationController?.navigationBar.scrollEdgeAppearance = appearance
    
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.tintColor = .systemYellow
    navigationController?.navigationBar.barTintColor = .black
    navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    
    title = "Задачи"
    view.addSubview(tableView)
    
    navigationItem.rightBarButtonItem = addButton
    
    tableView.backgroundColor = .black
    tableView.separatorColor = .darkGray
    
    tableView.register(ToDoCell.self, forCellReuseIdentifier: ToDoCell.indentifier)
    tableView.dataSource = self
    tableView.delegate = self
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
//  @objc private func addButtonTapped() {
//    presenter?.didTapAddButton()
//  }
  
  @objc private func addButtonTapped() {
    let addVC = AddEditViewController()
    navigationController?.pushViewController(addVC, animated: true)
  }
  
  private func filterContentForSearchText(_ searchText: String) {
    presenter?.filterContentForSearchText(searchText)
  }
}

extension ToDoListViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let presenter = presenter else { return 0 }
    return presenter.isSearching ? presenter.filteredItems.count : presenter.items?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.indentifier, for: indexPath) as! ToDoCell
    guard let presenter = presenter else { return cell }
    
    let item = presenter.isSearching ? presenter.filteredItems[indexPath.row] : presenter.items?[indexPath.row]
    
    guard let item = item else { return UITableViewCell() } //можно оставить cell
    cell.configure(with: item)
    
    cell.onCheckButtonTapped = { [weak self] in
      self?.presenter?.toggleCompletion(for: item.id)
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let item = presenter?.items?[indexPath.row] else { return }
    let configurator = AddEditConfigurator()
    let detailView = configurator.configure(with: item)
    navigationController?.pushViewController(detailView, animated: true)
  }
}

extension ToDoListViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text ?? "")
  }
}

extension ToDoListViewController: UISearchBarDelegate {
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    presenter?.searchDidCancel()
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    filterContentForSearchText(searchText)
  }
}




