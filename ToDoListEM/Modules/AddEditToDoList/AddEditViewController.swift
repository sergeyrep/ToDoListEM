import UIKit

final class AddEditViewController: UIViewController, AddEditViewControllerProtocol {
    
    private let titleLabel: UILabel = {
      let titleLable = UILabel()
      titleLable.textColor = .black
      titleLable.font = .systemFont(ofSize: 17, weight: .bold)
      titleLable.textAlignment = .center
      titleLable.translatesAutoresizingMaskIntoConstraints = false
      titleLable.textAlignment = .left
      return titleLable
    }()
  
  private let detailText: UILabel = {
    let detailText = UILabel()
    detailText.font = .systemFont(ofSize: 15, weight: .light)
    detailText.translatesAutoresizingMaskIntoConstraints = false
    detailText.textColor = .black
    detailText.numberOfLines = 0
    return detailText
  }()
  
  private let dateLabel: UILabel = {
    let dateLabel = UILabel()
    dateLabel.textColor = .gray
    dateLabel.font = .systemFont(ofSize: 13, weight: .light)
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    dateLabel.textAlignment = .left
    return dateLabel
  }()
  
  var presenter: AddEditPresenterProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  func setupUI() {
    view.backgroundColor = .white
    
    view.addSubview(titleLabel)
    view.addSubview(detailText)
    view.addSubview(dateLabel)
    
    if let item = presenter?.item {
      titleLabel.text = item.title
      detailText.text = item.details ?? "No details"
      displayCurrentDate(item.createdAt)
    }
      
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "Задача"
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      //titleLabel.heightAnchor.constraint(equalToConstant: 50),
      
      detailText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      detailText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      
      dateLabel.topAnchor.constraint(equalTo: detailText.bottomAnchor, constant: 20),
      dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
    ])
  }
  
  private func displayCurrentDate(_ date: Date) {
    
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    formatter.locale = Locale(identifier: "ru_RU")
    dateLabel.text = formatter.string(from: date)
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
