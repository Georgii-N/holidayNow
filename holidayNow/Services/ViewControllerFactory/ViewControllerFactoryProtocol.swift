import Foundation

protocol ViewControllerFactoryProtocol {
    func createOnboardingViewController() -> OnboardingViewController
    func createCongratulationTypeViewController() -> CongratulationTypeViewController
    func createFirstFormViewController() -> FirstFormViewController
    
    func createWaitingViewController() -> WaitingViewController
    func createSuccessViewController() -> SuccessViewController
    func createErrorNetworkViewController() -> ErrorNetworkViewController
    func createErrorAPIViewController() -> ErrorAPIViewController
}
