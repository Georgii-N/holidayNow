import UIKit

final class ViewControllerFactory: ViewControllerFactoryProtocol {
    weak var coordinator: CoordinatorProtocol?
    
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
}
