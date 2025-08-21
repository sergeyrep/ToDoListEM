import UIKit

final class AddEditViewController: UIViewController, AddEditViewControllerProtocol {
  
  private let titleLabel: UILabel = {
    let titleLable = UILabel()
    titleLable.textColor = .white
    titleLable.font = .systemFont(ofSize: 34, weight: .bold)
    titleLable.textAlignment = .center
    titleLable.translatesAutoresizingMaskIntoConstraints = false
    titleLable.textAlignment = .left
    titleLable.numberOfLines = 0
    return titleLable
  }()
  
  private let detailText: UILabel = {
    let detailText = UILabel()
    detailText.textColor = .white
    detailText.font = .systemFont(ofSize: 16, weight: .light)
    detailText.translatesAutoresizingMaskIntoConstraints = false
    detailText.numberOfLines = 0
    return detailText
  }()
  
  private let dateLabel: UILabel = {
    let dateLabel = UILabel()
    dateLabel.textColor = .gray
    dateLabel.font = .systemFont(ofSize: 12, weight: .light)
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    dateLabel.textAlignment = .left
    return dateLabel
  }()
  
  var todoItem: CDTodo?
  private let titleField = UITextField()
  private let detailsField = UITextView()
  private let saveButton = UIButton(type: .system)
  
  var presenter: AddEditPresenterProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.largeTitleDisplayMode = .never
    
  }
  
  private func configureForEdit() {
    if let todoItem = todoItem {
      title = "Редактировать задачу"
      titleField.text = todoItem.title
      detailsField.text = todoItem.details
    } else {
      title = "Новая задача"
    }
  }
  
  func setupUI() {
    view.backgroundColor = .black
    
    view.addSubview(titleLabel)
    view.addSubview(dateLabel)
    view.addSubview(detailText)
    
    if let item = presenter?.item {
      titleLabel.text = item.title
      detailText.text = item.details ?? "No details"
      displayCurrentDate(item.createdAt)
    }
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      //titleLabel.heightAnchor.constraint(equalToConstant: 50),
      
      dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      
      detailText.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
      detailText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
    ])
  }
  
  private func displayCurrentDate(_ date: Date) {
    
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    formatter.locale = Locale(identifier: "ru_RU")
    dateLabel.text = formatter.string(from: date)
  }
  
  @objc private func saveTapped() {
    guard let titleText = titleField.text, !titleText.isEmpty else { return }
    
    if let todoItem = todoItem {
      todoItem.title = titleText
      todoItem.details = detailsField.text
      todoItem.createdAt = todoItem.createdAt
    } else {
      let newTodo = CDTodo(context: CoreDataManager.shared.context)
      newTodo.id = Int64(Date().timeIntervalSince1970)
      newTodo.title = titleText
      newTodo.details = detailsField.text
      newTodo.createdAt = Date()
      newTodo.isCompleted = false
    }
    
    CoreDataManager.shared.save()
    navigationController?.popViewController(animated: true)
  }
}


//  private func setupNavigationBar() {
//      // Кнопка сохранения
//      let saveButton = UIBarButtonItem(
//        barButtonSystemItem: .save,
//        target: self,
//        action: #selector(saveButtonTapped)
//      )
//
//      // Кнопка отмены
//      let cancelButton = UIBarButtonItem(
//        barButtonSystemItem: .cancel,
//        target: self,
//        action: #selector(cancelButtonTapped)
//      )
//
//      navigationItem.rightBarButtonItem = saveButton
//      navigationItem.leftBarButtonItem = cancelButton
//    }
//
//    @objc private func saveButtonTapped() {
//      // Сохранение задачи
//      presenter?.saveTask()
//    }
//
//  @objc private func cancelButtonTapped() {
//      // Закрытие экрана
//      dismiss(animated: true)
//    }
