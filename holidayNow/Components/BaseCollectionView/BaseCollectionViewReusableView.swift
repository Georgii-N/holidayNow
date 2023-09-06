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
            headerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
