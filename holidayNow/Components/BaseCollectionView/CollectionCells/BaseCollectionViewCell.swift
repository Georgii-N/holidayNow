import UIKit

final class BaseCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Dependencies:
    weak var delegate: BaseCollectionViewCellDelegate?
    
    // MARK: - Constants and Variables:
    private enum BaseCellUIConstants {
        static let cellRadius: CGFloat = 18
        static let borderInset: CGFloat = 8
        static let narrowBorderWidth: CGFloat = 1
        static let wideBorderWidth: CGFloat = 2
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
    
    private lazy var removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.setTitle("-", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(cgColor: layer.borderColor ?? UIColor.gray.cgColor)
        
        return button
    }()
    
    private lazy var interestImageView = UIImageView()
    
    // MARK: - Lifecycle:
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods:
    func setupInterestModel(model: CellModel) {
        cellModel = model
    }
    
    func startEditingButton() {
        addRemoveButton()
        addEditingAnimation()
    }
    
    // MARK: - Private Methods:
    private func changeCellState() {
        if isSelected {
            layer.borderColor = UIColor.black.cgColor
            layer.borderWidth = BaseCellUIConstants.wideBorderWidth
            removeButton.backgroundColor = UIColor.black
            interestImageView.image = interestImageView.image?.withTintColor(.black, renderingMode: .alwaysOriginal)
            nameLabel.textColor = .black
        } else {
            layer.borderColor = UIColor.lightGray.cgColor
            layer.borderWidth = BaseCellUIConstants.narrowBorderWidth
            removeButton.backgroundColor = UIColor.lightGray
            interestImageView.image = interestImageView.image?.withTintColor(.gray, renderingMode: .alwaysOriginal)
            nameLabel.textColor = .gray
        }
    }
    
    private func addRemoveButton() {
        setupView(removeButton)
        
        NSLayoutConstraint.activate([
            removeButton.heightAnchor.constraint(equalToConstant: 20),
            removeButton.widthAnchor.constraint(equalToConstant: 20),
            removeButton.centerYAnchor.constraint(equalTo: topAnchor, constant: 3),
            removeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    // MARK: - Objc Methods:
    @objc private func editCell() {
        guard let cellModel else { return }
        let animations = layer.animationKeys()
        let isHasAnimations = animations != nil
        
        if !cellModel.isDefault && !isHasAnimations {
            delegate?.startEditingNonDefaultButtons()
        }
    }
}

// MARK: - Setup Views:
private extension BaseCollectionViewCell {
    func setupViews() {
       layer.borderColor = UIColor.lightGray.cgColor
       layer.borderWidth = BaseCellUIConstants.narrowBorderWidth
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
    
    func setupGesture() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(editCell))
        addGestureRecognizer(gesture)
    }
}

// MARK: - Setup Animation:
extension BaseCollectionViewCell {
    func addEditingAnimation() {
        let wobbleAnimation = CAKeyframeAnimation(keyPath: "transform.rotation")
        wobbleAnimation.values = [0.0, -0.025, 0.0, 0.025, 0.0]
        wobbleAnimation.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
        wobbleAnimation.duration = 0.25
        wobbleAnimation.isAdditive = true
        wobbleAnimation.repeatCount = .greatestFiniteMagnitude
        
        layer.add(wobbleAnimation, forKey: "wobble")
    }
}
