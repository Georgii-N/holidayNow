import UIKit

final class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    // MARK: - Constants and Variables:
    let cellSpacing: CGFloat = 10
    let sideSpacing: CGFloat = 20
    
    // MARK: - Override Methods:
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        minimumLineSpacing = cellSpacing
        sectionInset = UIEdgeInsets(top: cellSpacing, left: sideSpacing, bottom: cellSpacing, right: sideSpacing)
        
        let attributes = super.layoutAttributesForElements(in: rect)
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + cellSpacing
            maxY = max(layoutAttribute.frame.maxX, maxY)
        }
        
        return attributes
    }
}
