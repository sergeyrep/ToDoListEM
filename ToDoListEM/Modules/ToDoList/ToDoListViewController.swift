import UIKit

class ToDoListViewController: UIViewController, TodoListViewProtocol {
  
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.separatorColor = .darkGray
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  var presenter: ToDoListPresenterProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    presenter?.viewDidLoad()
    setupUI()
  }
  
  func reloadData() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
  private func setupUI() {
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "Задачи"
    view.addSubview(tableView)
    
    tableView.register(ToDoCell.self, forCellReuseIdentifier: ToDoCell.indentifier)
    tableView.dataSource = self
    tableView.delegate = self
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  @objc private func addButtonTapped() {
    presenter?.didTapAddButton()
  }
}

extension ToDoListViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter?.items.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.indentifier, for: indexPath) as! ToDoCell
    guard let item = presenter?.items[indexPath.row] else { return cell }
    cell.configure(with: item)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let item = presenter?.items[indexPath.row] else { return }
    let configurator = AddEditConfigurator()
    let detailView = configurator.configure(with: item)
    navigationController?.pushViewController(detailView, animated: true)
    print("aufff")
  }
}

class ToDoCell: UITableViewCell {
  
  static let indentifier: String = "ToDoCell"
  
  func configure(with task: ToDo) {
    var content = defaultContentConfiguration()
    content.text = task.title
    content.secondaryText = task.createdAt.formatted()
    contentConfiguration = content
    
    accessoryType = task.isCompleted ? .checkmark : .none
  }
}
