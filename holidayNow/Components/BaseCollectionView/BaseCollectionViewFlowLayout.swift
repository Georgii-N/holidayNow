import UIKit

final class BaseCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    // MARK: - Override Methods:
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        minimumLineSpacing = UIConstants.cellsSpacing
        sectionInset = UIEdgeInsets(top: UIConstants.sideInset,
                                    left: UIConstants.sideInset,
                                    bottom: UIConstants.sideInset,
                                    right: UIConstants.sideInset)
        
        let attributes = super.layoutAttributesForElements(in: rect)
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        
        attributes?.forEach { layoutAttribute in
            guard layoutAttribute.representedElementCategory == .cell else {
                return
            }
            
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + UIConstants.cellsSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        
        return attributes
    }
}
