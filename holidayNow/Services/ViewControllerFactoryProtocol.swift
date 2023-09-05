import Foundation

protocol ViewControllerFactoryProtocol {
    func createOnboardingViewController() -> OnboardingViewController
    func createSuccessViewController() -> SuccessViewController
    
}
