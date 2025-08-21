import UIKit

final class AddEditViewController: UIViewController, AddEditViewInput {
  var output: AddEditViewOutput!

  private let titleField: UITextField = {
    let tf = UITextField()
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.textColor = .white
    tf.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
    tf.layer.cornerRadius = 8
    tf.layer.masksToBounds = true
    tf.borderStyle = .none
    tf.placeholder = "Название задачи"
    tf.setContentHuggingPriority(.defaultHigh, for: .vertical)
    tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
    tf.leftViewMode = .always
    return tf
  }()

  private let detailsView: UITextView = {
    let tv = UITextView()
    tv.translatesAutoresizingMaskIntoConstraints = false
    tv.textColor = .white
    tv.backgroundColor = UIColor.darkGray.withAlphaComponent(0.2)
    tv.layer.cornerRadius = 12
    tv.isScrollEnabled = true
    tv.font = .systemFont(ofSize: 16)
    return tv
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    title = "Задача"

    setupLayout()
    setupNavBar()
    output.viewDidLoad()
  }

  private func setupLayout() {
    view.addSubview(titleField)
    view.addSubview(detailsView)

    NSLayoutConstraint.activate([
      titleField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
      titleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      titleField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      titleField.heightAnchor.constraint(equalToConstant: 44),

      detailsView.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 12),
      detailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      detailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      detailsView.heightAnchor.constraint(equalToConstant: 220)
    ])
  }

  private func setupNavBar() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .save,
      target: self,
      action: #selector(saveTapped)
    )
  }

  @objc private func saveTapped() {
    guard let title = titleField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
          !title.isEmpty else {
      let alert = UIAlertController(title: "Введите название", message: nil, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default))
      present(alert, animated: true)
      return
    }
    output.save(title: title, details: detailsView.text?.trimmingCharacters(in: .whitespacesAndNewlines))
  }

  // MARK: - AddEditViewInput

  func fill(with todo: ToDo?) {
    if let todo {
      title = "Редактирование"
      titleField.text = todo.title
      detailsView.text = todo.details
    } else {
      title = "Новая задача"
      detailsView.text = ""
    }
  }

  func close() {
    navigationController?.popViewController(animated: true)
  }
}
