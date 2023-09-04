import UIKit

final class CustomCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants and Variables:
    override var isSelected: Bool {
        didSet {
            changeCellState()
        }
    }
    
    private var interestModel: GreetingTarget? {
        didSet {
            guard let interestModel else { return }
            interestImageView.image = interestModel.image
            nameLabel.text = interestModel.name
        }
    }
    
    // MARK: - UI:
    private lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.font = .bodySmallRegularFont
        label.textColor = .black

        return label
    }()
    
    private lazy var interestImageView = UIImageView()

    // MARK: - Lifecycle:
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods:
    func setupInterestModel(model: GreetingTarget) {
        interestModel = model
    }
    
    // MARK: - Private Methods:
    private func changeCellState() {
        if isSelected {
            layer.borderColor = UIColor.black.cgColor
            layer.borderWidth = 2
        } else {
            layer.borderColor = UIColor.gray.cgColor
            layer.borderWidth = 1
        }
    }
}

// MARK: - Setup Views:
private extension CustomCollectionViewCell {
    func setupViews() {
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 15
        
        [interestImageView, nameLabel].forEach(setupView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            interestImageView.widthAnchor.constraint(equalToConstant: 20),
            interestImageView.heightAnchor.constraint(equalToConstant: 20),
            interestImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            interestImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: interestImageView.trailingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
        ])
    }
}
