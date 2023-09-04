import UIKit

final class CustomCollectionView: UICollectionView {
    
    // MARK: - Lifecycle:
    init() {
        let layout = CustomCollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        super.init(frame: .zero, collectionViewLayout: layout)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Views:
extension CustomCollectionView {
    private func setupViews() {
        backgroundColor = .whiteDay
        allowsMultipleSelection = true
    }
}
