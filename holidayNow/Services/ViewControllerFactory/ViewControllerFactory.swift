import UIKit

final class ViewControllerFactory: ViewControllerFactoryProtocol {
    
    // MARK: - Dependencies
    weak var coordinator: CoordinatorProtocol?
    private var dataProvider: DataProviderProtocol
    
    // MARK: - Lifecycle
    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    // MARK: - Public Methods
    func createOnboardingViewController() -> OnboardingViewController {
        let onboardingViewController = OnboardingViewController(coordinator: coordinator)
        return onboardingViewController
    }
    
    func createCongratulationTypeViewController() -> CongratulationTypeViewController {
        let congratulationViewModel = CongratulationTypeViewModel(dataProvider: dataProvider)
        return CongratulationTypeViewController(coordinator: coordinator, viewModel: congratulationViewModel)
    }
    
    func createFirstFormViewController() -> FirstFormViewController {
        let firstViewModel = FirstFormViewModel(dataProvider: dataProvider)
        let collectionProvider = FirstFormCollectionViewProvider(viewModel: firstViewModel)
        let viewController = FirstFormViewController(coordinator: coordinator, viewModel: firstViewModel, collectionProvider: collectionProvider)
        collectionProvider.setViewController(with: viewController)
        
        return viewController
    }
    
    func createSecondFormViewController() -> SecondFormViewController {
        let secondViewModel = SecondFormViewModel(dataProvider: dataProvider)
        let collectionProvider = SecondFormCollectionProvider(viewModel: secondViewModel)
        let viewController = SecondFormViewController(coordinator: coordinator, viewModel: secondViewModel, collectionProvider: collectionProvider)
        collectionProvider.setupViewController(with: viewController)
        
        return viewController
    }
    
    // Response screens
    func createWaitingViewController() -> WaitingViewController {
        let waitingViewModel = WaitingViewModel(dataProvider: dataProvider)
        let waitingViewController = WaitingViewController(coordinator: coordinator, waitingViewModel: waitingViewModel)
        return waitingViewController
    }
    
    func createSuccessViewController() -> SuccessViewController {
        let resultText = dataProvider.getResultText()
        let successViewModel = SuccessViewModel(textResult: resultText, dataProvider: dataProvider)
        let successViewController = SuccessViewController(coordinator: coordinator, successViewModel: successViewModel)
        return successViewController
    }
    
    func createErrorNetworkViewController() -> ErrorNetworkViewController {
        let errorNetworkViewController = ErrorNetworkViewController(coordinator: coordinator)
        return errorNetworkViewController
    }
    
    func createEditViewController() -> EditViewController {
        let resultText = dataProvider.getResultText()
        let editViewModel = EditViewModel(resultText: resultText, dataProvider: dataProvider)
        let editViewController = EditViewController(coordinator: coordinator, editViewModel: editViewModel)
        return editViewController
    }
}
