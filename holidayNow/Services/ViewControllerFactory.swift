import UIKit

final class ViewControllerFactory: ViewControllerFactoryProtocol {
    // MARK: - Dependencies
    weak var coordinator: CoordinatorProtocol?
    
    // MARK: - Public Methods
    func createOnboardingViewController() -> OnboardingViewController {
        let onboardingViewController = OnboardingViewController(coordinator: coordinator ?? nil)
        return onboardingViewController
    }
    
    func createSuccessViewController() -> SuccessViewController {
        let successViewController = SuccessViewController(coordinator: coordinator ?? nil)
        return successViewController
    }
    
    func createCongratulationTypeViewController() -> CongratulationTypeViewController {
        let congratulationTypeViewController = CongratulationTypeViewController(coordinator: coordinator ?? nil)
        return congratulationTypeViewController
    }
    
    func createFirstFormViewController() -> FirstFormViewController {
        let firstViewModel = FirstFormViewModel()
        return FirstFormViewController(coordinator: coordinator, viewModel: firstViewModel)
    }
}
