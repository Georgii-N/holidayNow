import UIKit

final class BaseCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Dependencies:
    weak var delegate: BaseCollectionViewCellDelegate?
    
    // MARK: - Constants and Variables:
    private enum BaseCellUIConstants {
        static let cellCornerRadius: CGFloat = 18
        static let buttonCornerRadius: CGFloat = 10
        
        static let borderInset: CGFloat = 8
        static let buttonRightInset: CGFloat = -10
        static let buttonTopInset: CGFloat = 3
        
        static let buttonSide: CGFloat = 20
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
        button.layer.cornerRadius = BaseCellUIConstants.buttonCornerRadius
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
        setupTargets()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stopAnimation()
    }
    
    // MARK: - Public Methods:
    func setupInterestModel(model: CellModel) {
        cellModel = model
    }
    
    func startEditingButton() {
        addRemoveButton()
        addEditingAnimation()
    }
    
    func stopAnimation() {
        removeButton.removeFromSuperview()
        layer.removeAllAnimations()
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
            stopAnimation()
        }
    }
    
    private func addRemoveButton() {
        setupView(removeButton)
        
        NSLayoutConstraint.activate([
            removeButton.heightAnchor.constraint(equalToConstant: BaseCellUIConstants.buttonSide),
            removeButton.widthAnchor.constraint(equalToConstant: BaseCellUIConstants.buttonSide),
            removeButton.centerYAnchor.constraint(equalTo: topAnchor, constant: BaseCellUIConstants.buttonTopInset),
            removeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: BaseCellUIConstants.buttonRightInset)
        ])
    }
    
    private func makeVibro() {
        HapticsManager().vibrate()
    }
    
    // MARK: - Objc Methods:
    @objc private func editCell() {
        guard let cellModel else { return }
        let animations = layer.animationKeys()
        let isHasAnimations = animations != nil
        
        if !cellModel.isDefault && !isHasAnimations {
            delegate?.startEditingNonDefaultCells()
            makeVibro()
        }
    }
    
    @objc private func removeCell() {
        delegate?.remove(cell: self)
    }
}

// MARK: - Setup Views:
private extension BaseCollectionViewCell {
    func setupViews() {
       layer.borderColor = UIColor.lightGray.cgColor
       layer.borderWidth = BaseCellUIConstants.narrowBorderWidth
       layer.cornerRadius = BaseCellUIConstants.cellCornerRadius
        
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
    
    func setupTargets() {
        removeButton.addTarget(self, action: #selector(removeCell), for: .touchUpInside)
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
