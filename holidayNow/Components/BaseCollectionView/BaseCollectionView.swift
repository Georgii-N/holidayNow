import UIKit

final class BaseCollectionView: UICollectionView {
    
    // MARK: - Lifecycle:
    init() {
        let layout = BaseCollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        super.init(frame: .zero, collectionViewLayout: layout)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Views:
extension BaseCollectionView {
    private func setupViews() {
        backgroundColor = .whiteDay
        allowsMultipleSelection = true
    }
}
