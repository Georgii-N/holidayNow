import UIKit

final class ViewControllerFactory: ViewControllerFactoryProtocol {
    
    func createOnboardingViewController() -> OnboardingViewController {
            let onboardingViewController = OnboardingViewController()
            return onboardingViewController
        }
    
    func createSuccessViewController() -> SuccessViewController {
        let successViewController = SuccessViewController()
            return successViewController
        }
}
