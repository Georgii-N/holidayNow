import UIKit

final class FirstFormCollectionViewProvider: NSObject {
    
    // MARK: - Dependencies:
    private let viewModel: FirstFormViewModelProtocol?
    private var viewController: FirstFormViewController?
    
    // MARK: - Lifecycle:
    init(viewModel: FirstFormViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    // MARK: - Public Methods:
    func setViewController(with viewController: FirstFormViewController) {
        self.viewController = viewController
    }
}

extension FirstFormCollectionViewProvider: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let interests = viewModel?.interestsObservable.wrappedValue.interests else { return 0 }
        
        return interests.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let interests = viewModel?.interestsObservable.wrappedValue.interests else { return UICollectionViewCell() }
        
        if indexPath.row == interests.count {
            // Enter cell:
            let cell: BaseCollectionViewEnterCell = collectionView.dequeueReusableCell(
                indexPath: indexPath,
                with: Resources.Identifiers.formEnterInterestCollectionVewCell)
            
            cell.delegate = viewController
            cell.setupCellWidht(value: viewController?.view.frame.width ?? 0)
            
            return cell
        } else {
            // Default cell:
            let cell: BaseCollectionViewCell = collectionView.dequeueReusableCell(
                indexPath: indexPath,
                with: Resources.Identifiers.formInterestCollectionVewCell)
            
            let model = interests[indexPath.row]
            
            cell.delegate = viewController
            cell.setupInterestModel(model: CellModel(name: model.name, image: model.image))
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let text = viewModel?.interestsObservable.wrappedValue.name
        var id: String
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            id = Resources.Identifiers.collectionReusableView
        default:
            id = ""
        }
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: id,
            for: indexPath) as? BaseCollectionViewReusableView else { return UICollectionReusableView() }
        
        headerView.setupLabelName(with: text ?? "")
        
        return headerView
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FirstFormCollectionViewProvider: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: UIConstants.inputHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView,
                                             viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader,
                                             at: indexPath)
        
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                         height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)
    }
}
