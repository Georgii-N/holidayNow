import UIKit

final class AppCoordinator: CoordinatorProtocol {
    
    // MARK: - Constants and Variables
    internal var navigationController: UINavigationController
    internal var viewControllerFactory: ViewControllerFactoryProtocol
    
    // MARK: - LifeCycle:
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllerFactoryProtocol) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    // MARK: - Public Methods
    func start() {
        let onboardingViewController = viewControllerFactory.createOnboardingViewController()
        navigationController.pushViewController(onboardingViewController, animated: true)
    }
    
    func goToCongratulationTypeViewController() {
        let congratulationTypeViewController = viewControllerFactory.createCongratulationTypeViewController()
        navigationController.pushViewController(congratulationTypeViewController, animated: true)
    }
    
    func goToFirstFormViewController() {
        let firstFormViewController = viewControllerFactory.createFirstFormViewController()
        navigationController.pushViewController(firstFormViewController, animated: true)
    }
    
    // Response Screens
    func goToWaitingViewController() {
        let waitingViewController = viewControllerFactory.createWaitingViewController()
        navigationController.pushViewController(waitingViewController, animated: true)
    }
    
    func goToSuccessResultViewController() {
        let successViewController = viewControllerFactory.createSuccessViewController()
        navigationController.pushViewController(successViewController, animated: true)
    }
    
    func goToErrorNetworkViewController() {
        let errorNetworkViewController = viewControllerFactory.createErrorNetworkViewController()
        navigationController.pushViewController(errorNetworkViewController, animated: true)
    }
    
    func goToErrorAPIViewController() {
        let errorAPIViewController = viewControllerFactory.createErrorAPIViewController()
        navigationController.pushViewController(errorAPIViewController, animated: true)
    }
}
