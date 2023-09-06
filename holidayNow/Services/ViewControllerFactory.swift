import UIKit

final class ViewControllerFactory: ViewControllerFactoryProtocol {
    
    // MARK: - Dependencies
    weak var coordinator: CoordinatorProtocol?
    
    // MARK: - Public Methods
    func createOnboardingViewController() -> OnboardingViewController {
        let onboardingViewController = OnboardingViewController(coordinator: coordinator)
        return onboardingViewController
    }
    
    func createCongratulationTypeViewController() -> CongratulationTypeViewController {
        let congratulationTypeViewController = CongratulationTypeViewController(coordinator: coordinator)
        return congratulationTypeViewController
    }
    
    func createFirstFormViewController() -> FirstFormViewController {
        let firstViewModel = FirstFormViewModel()
        return FirstFormViewController(coordinator: coordinator, viewModel: firstViewModel)
    }
    
    // Response screens
    func createWaitingViewController() -> WaitingViewController {
        let waitingViewModel = WaitingViewModel()
        let waitingViewController = WaitingViewController(coordinator: coordinator, waitingViewModel: waitingViewModel)
        return waitingViewController
    }
    
    func createSuccessViewController() -> SuccessViewController {
        let successViewController = SuccessViewController(coordinator: coordinator)
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
