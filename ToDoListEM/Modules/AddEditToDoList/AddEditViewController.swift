import UIKit

final class AddEditViewController: UIViewController, AddEditViewControllerProtocol {
    
    private let titleLabel: UILabel = {
      let titleLable = UILabel()
      titleLable.textColor = .black
      titleLable.font = .systemFont(ofSize: 17, weight: .medium)
      titleLable.textAlignment = .center
      titleLable.translatesAutoresizingMaskIntoConstraints = false
      titleLable.textAlignment = .left
      return titleLable
    }()
  
  var presenter: AddEditPresenterProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  func setupUI() {
    
    titleLabel.text = presenter?.item.title
    view.backgroundColor = .white
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "Задача"
  
    view.addSubview(titleLabel)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8),
      titleLabel.heightAnchor.constraint(equalToConstant: 50),
      
      titleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
    ])
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
}


