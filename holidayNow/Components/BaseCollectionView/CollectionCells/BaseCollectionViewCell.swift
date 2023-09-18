import UIKit

final class BaseCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Dependencies:
    weak var delegate: BaseCollectionViewCellDelegate?
    
    // MARK: - Constants and Variables:
    private enum BaseCellUIConstants {
        static let cellRadius: CGFloat = 18
        static let borderInset: CGFloat = 8
    }
    
    private(set) var cellModel: CellModel? {
        didSet {
            guard let cellModel else { return }
            interestImageView.image = cellModel.image
            nameLabel.text = cellModel.name
        }
    }
    
    override var isSelected: Bool {
        didSet {
            changeCellState()
            delegate?.changeTargetState(isAdded: isSelected, cell: self)
        }
    }
    
    // MARK: - UI:
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .captionMediumRegularFont
        label.textColor = .gray
        
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
    func setupInterestModel(model: CellModel) {
        cellModel = model
    }
    
    // MARK: - Private Methods:
    private func changeCellState() {
        if isSelected {
            layer.borderColor = UIColor.black.cgColor
            layer.borderWidth = 2
            interestImageView.image = interestImageView.image?.withTintColor(.black, renderingMode: .alwaysOriginal)
            nameLabel.textColor = .black
        } else {
            layer.borderColor = UIColor.lightGray.cgColor
            layer.borderWidth = 1
            interestImageView.image = interestImageView.image?.withTintColor(.gray, renderingMode: .alwaysOriginal)
            nameLabel.textColor = .gray
        }
    }
}

// MARK: - Setup Views:
private extension BaseCollectionViewCell {
    func setupViews() {
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = BaseCellUIConstants.cellRadius
        
        [interestImageView, nameLabel].forEach(setupView)
    }
    
    func setupConstraints() {
        setupInterestsImageViewConstraints()
        setupNameLabelConstraints()
    }
    
    func setupInterestsImageViewConstraints() {
        NSLayoutConstraint.activate([
            interestImageView.widthAnchor.constraint(equalToConstant: UIConstants.sideSize),
            interestImageView.heightAnchor.constraint(equalToConstant: UIConstants.sideSize),
            interestImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            interestImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: BaseCellUIConstants.borderInset)
        ])
    }
    
    func setupNameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: interestImageView.trailingAnchor, constant: UIConstants.smallInset),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -BaseCellUIConstants.borderInset)
        ])
    }
}
