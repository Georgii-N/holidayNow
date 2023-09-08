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
        return FirstFormViewController(coordinator: coordinator, viewModel: firstViewModel)
    }
    
    func createSecondFormViewController() -> SecondFormViewController {
        let secondViewModel = SecondFormViewModel(dataProvider: dataProvider)
        return SecondFormViewController(coordinator: coordinator, viewModel: secondViewModel)
    }
    
    // Response screens
    func createWaitingViewController() -> WaitingViewController {
        let waitingViewModel = WaitingViewModel(dataProvider: dataProvider)
        let waitingViewController = WaitingViewController(coordinator: coordinator, waitingViewModel: waitingViewModel)
        return waitingViewController
    }
    
    func createSuccessViewController() -> SuccessViewController {
        let resultText = dataProvider.getResultText()
        let successViewModel = SuccessViewModel(textResult: resultText)
        let successViewController = SuccessViewController(coordinator: coordinator, successViewModel: successViewModel)
        return successViewController
    }
    
    func createErrorNetworkViewController() -> ErrorNetworkViewController {
        let errorNetworkViewController = ErrorNetworkViewController(coordinator: coordinator)
        return errorNetworkViewController
    }
    
    func createErrorAPIViewController() -> ErrorAPIViewController {
        let errorAPIViewController = ErrorAPIViewController(coordinator: coordinator)
        return errorAPIViewController
    }
}
