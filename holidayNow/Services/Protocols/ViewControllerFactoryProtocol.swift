import Foundation

protocol ViewControllerFactoryProtocol {
    func createOnboardingViewController() -> OnboardingViewController
    func createSuccessViewController() -> SuccessViewController
    func createCongratulationTypeViewController() -> CongratulationTypeViewController
    func createFirstFormViewController() -> FirstFormViewController
}
