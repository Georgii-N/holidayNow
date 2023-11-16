import UIKit

final class SecondFormCollectionProvider: NSObject {
    
    // MARK: - Dependencies:
    private let viewModel: SecondFormViewModelProtocol
    
    weak private var viewController: SecondFormViewController?
    
    // MARK: - Lifecycle:
    init(viewModel: SecondFormViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    // MARK: - Public Methods:
    func setupViewController(with viewController: SecondFormViewController) {
        self.viewController = viewController
    }
    
    // MARK: - Private Methods:
    private func getParticularCell(isDefault: Bool, indexPath: IndexPath, isHoliday: Bool) -> UICollectionViewCell {
        guard let viewController else { return UICollectionViewCell() }
        let countOfDefaultHolidays = 4
        
        if isDefault {
            let defaultCell: BaseCollectionViewCell = viewController.secondFormCollectionView.dequeueReusableCell(
                indexPath: indexPath,
                with: Resources.Identifiers.formInterestCollectionVewCell)
            defaultCell.delegate = viewController
            
            if isHoliday {
                let model = viewModel.holidaysObserver.wrappedValue.holidays[indexPath.row]
                let isDefaultHoliday = indexPath.row + 1 <= countOfDefaultHolidays
                defaultCell.setupInterestModel(model: CellModel(name: model.name, image: model.image, isDefault: isDefaultHoliday))
                
                return defaultCell
            } else {
                let model = viewModel.intonations.intonations[indexPath.row]
                defaultCell.setupInterestModel(model: CellModel(name: model.name, image: model.image, isDefault: true))
                
                return defaultCell
            }
        } else {
            let defaultEnterCell: BaseCollectionViewEnterCell = viewController.secondFormCollectionView.dequeueReusableCell(
                indexPath: indexPath,
                with: Resources.Identifiers.formEnterInterestCollectionVewCell)
            
            defaultEnterCell.delegate = viewController
            defaultEnterCell.setupCellWidht(value: viewController.view.frame.width)
            
            return defaultEnterCell
        }
    }
}

// MARK: - UICollectionViewDataSource:
extension SecondFormCollectionProvider: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.holidaysObserver.wrappedValue.holidays.count + 1
        case 1:
            return viewModel.intonations.intonations.count
        default:
            return  0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == viewModel.holidaysObserver.wrappedValue.holidays.count {
                guard let cell = getParticularCell(
                    isDefault: false,
                    indexPath: indexPath,
                    isHoliday: true) as? BaseCollectionViewEnterCell else { return UICollectionViewCell() }
                
                return cell
            } else {
                guard let cell = getParticularCell(
                    isDefault: true,
                    indexPath: indexPath,
                    isHoliday: true) as? BaseCollectionViewCell else { return UICollectionViewCell() }
                
                return cell
            }
        case 1:
            guard let cell = getParticularCell(
                isDefault: true,
                indexPath: indexPath,
                isHoliday: false) as? BaseCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
        default:
            return UICollectionViewCell()
        }
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

// MARK: - UICollectionViewDelegateFlowLayout:
extension SecondFormCollectionProvider: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: UIConstants.inputHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedIndex = collectionView.indexPathsForSelectedItems else { return }
        
        selectedIndex.forEach { index in
            if index.section == indexPath.section && index.row != indexPath.row {
                collectionView.deselectItem(at: index, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var text: String
        var id: String
        
        switch indexPath.section {
        case 0:
            text = viewModel.holidaysObserver.wrappedValue.name
        case 1:
            text = viewModel.intonations.name
        default:
            text = ""
        }
        
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
        
        headerView.setupLabelName(with: text)
        
        return headerView
    }
}
