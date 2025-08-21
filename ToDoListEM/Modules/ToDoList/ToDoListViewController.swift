import UIKit

final class ToDoListViewController: UIViewController, ToDoListViewProtocol {
  
  var output: ToDoListViewProtocol?
  
  private var data: [ToDo] = []
  private let tableView = UITableView(frame: .zero, style: .plain)
  private let searchController = UISearchController(searchResultsController: nil)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Задачи"
    view.backgroundColor = .black
    
    setupTable()
    setupSearch()
    setupNavBar()
    
    output?.viewDidLoad()
  }
  
  private func setupTable() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.backgroundColor = .black
    tableView.separatorColor = .darkGray
    tableView.register(ToDoCell.self, forCellReuseIdentifier: ToDoCell.indentifier)
    tableView.dataSource = self
    tableView.delegate = self
    view.addSubview(tableView)
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  private func setupSearch() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Поиск"
    searchController.searchBar.tintColor = .systemYellow
    if let tf = searchController.searchBar.value(forKey: "searchField") as? UITextField {
      tf.textColor = .white
      tf.backgroundColor = .darkGray
      tf.attributedPlaceholder = NSAttributedString(
        string: "Поиск",
        attributes: [.foregroundColor: UIColor.lightGray]
      )
    }
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    definesPresentationContext = true
  }
  
  private func setupNavBar() {
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    navigationItem.rightBarButtonItem = addButton
    
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .black
    appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.tintColor = .systemYellow
  }
  
  @objc private func addTapped() {
    output?.didTapAdd()
  }
  
  func show(todos: [ToDo]) {
    self.data = todos
    tableView.reloadData()
  }
  
  func reloadRow(at index: Int) {
    guard index < data.count else { return }
    tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
  }
  
  func didTapAdd() {}
  
  func didSelectRow(at index: Int) {}
  
  func didToggleDone(at index: Int) {}
  
  func didSearch(text: String) {}
}

extension ToDoListViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.indentifier, for: indexPath) as! ToDoCell
    let item = data[indexPath.row]
    cell.configure(with: item)
    cell.onCheckButtonTapped = { [weak self] in
      self?.output?.didToggleDone(at: indexPath.row)
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    output?.didSelectRow(at: indexPath.row)
  }
}

extension ToDoListViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    output?.didSearch(text: searchController.searchBar.text ?? "")
  }
}
