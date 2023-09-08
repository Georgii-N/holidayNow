import UIKit

final class BaseCollectionViewReusableView: UICollectionReusableView {
    
    // MARK: - UI:
    private lazy var headerLabel: UILabel = {
       let label = UILabel()
        label.font = .captionLargeBoldFont
        label.textColor = .blackDay
        
        return label
    }()
    
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
    func setupLabelName(with text: String) {
        headerLabel.text = text
    }
}

// MARK: - Setup Views:
private extension BaseCollectionViewReusableView {
    func setupViews() {
        setupView(headerLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 40),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
