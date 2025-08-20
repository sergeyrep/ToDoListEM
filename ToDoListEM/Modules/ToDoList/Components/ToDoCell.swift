import UIKit

class ToDoCell: UITableViewCell {
  
  static let indentifier: String = "ToDoCell"
  
  private let checkButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.layer.cornerRadius = 12 // Круглая форма
    button.layer.borderWidth = 2
    button.layer.borderColor = UIColor.lightGray.cgColor
    button.backgroundColor = .clear
    button.isUserInteractionEnabled = false // Отключаем взаимодействие, обрабатываем в ячейке
    return button
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = .systemFont(ofSize: 16, weight: .medium)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let detailsLabel: UILabel = {
    let label = UILabel()
    label.textColor = .lightGray
    label.font = .systemFont(ofSize: 14, weight: .regular)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let dateLabel: UILabel = {
    let dateLabel = UILabel()
    dateLabel.textColor = .gray
    dateLabel.font = .systemFont(ofSize: 13, weight: .light)
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    dateLabel.textAlignment = .left
    return dateLabel
  }()
  
  private var isCompleted: Bool = false {
    didSet {
      updateCheckButtonAppearance()
    }
  }
  
  var onCheckButtonTapped: (() -> Void)?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupCell()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupCell() {
    backgroundColor = .black
    contentView.backgroundColor = .black
    
    contentView.addSubview(checkButton)
    contentView.addSubview(titleLabel)
    contentView.addSubview(detailsLabel)
    contentView.addSubview(dateLabel)
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(checkButtonTapped))
    checkButton.addGestureRecognizer(tapGesture)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    
    NSLayoutConstraint.activate([
      checkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      checkButton.widthAnchor.constraint(equalToConstant: 24),
      checkButton.heightAnchor.constraint(equalToConstant: 24),
      
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      
      detailsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
      detailsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      detailsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      //detailsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      
      dateLabel.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 4),
      dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
    ])
  }
  
  func configure(with item: ToDo) {
    
    titleLabel.text = item.title
    detailsLabel.text = item.details
    //dateLabel.text = item.createdAt.formatted()
    displayCurrentDate(item.createdAt)
    
    titleLabel.textColor = .white
    detailsLabel.textColor = .lightGray
    dateLabel.textColor = .gray
    
    isCompleted = item.isCompleted
    
    // Обновляем внешний вид текста в зависимости от выполнения
    if item.isCompleted {
      titleLabel.textColor = .darkGray
      detailsLabel.textColor = .darkGray
      titleLabel.attributedText = item.title.strikeThrough()
      if let details = item.details {
        detailsLabel.attributedText = details.strikeThrough()
      }
    } else {
      titleLabel.textColor = .white
      detailsLabel.textColor = .lightGray
      titleLabel.attributedText = NSAttributedString(string: item.title)
      detailsLabel.text = item.details
    }
    
    if let details = item.details, !details.isEmpty {
      detailsLabel.text = details
      detailsLabel.isHidden = false
      dateLabel.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 4).isActive = true
    } else {
      detailsLabel.isHidden = true
      detailsLabel.text = "No details"
      dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
    }
  }
  
  private func displayCurrentDate(_ date: Date) {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yy"
    formatter.locale = Locale(identifier: "ru_RU")
    dateLabel.text = formatter.string(from: date)
  }
  
  private func updateCheckButtonAppearance() {
    if isCompleted {
      // Выполнено - закрашенный кружок с галочкой
      checkButton.backgroundColor = .systemBlue
      checkButton.layer.borderColor = UIColor.systemBlue.cgColor
      checkButton.setImage(UIImage(systemName: "checkmark")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
    } else {
      // Не выполнено - пустой кружок
      checkButton.backgroundColor = .clear
      checkButton.layer.borderColor = UIColor.lightGray.cgColor
      checkButton.setImage(nil, for: .normal)
    }
  }
  
  @objc private func checkButtonTapped() {
    isCompleted.toggle()
    updateCheckButtonAppearance()
    onCheckButtonTapped?() // Уведомляем о изменении
  }
}

extension String {
  func strikeThrough() -> NSAttributedString {
    let attributeString = NSMutableAttributedString(string: self)
    attributeString.addAttribute(
      .strikethroughStyle,
      value: NSUnderlineStyle.single.rawValue,
      range: NSMakeRange(0, attributeString.length)
    )
    return attributeString
  }
}
