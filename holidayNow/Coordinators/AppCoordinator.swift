import UIKit

final class AppCoordinator: CoordinatorProtocol {
    
    // MARK: - Constants and Variables:
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
    
    func goToSuccessResultViewController() {
        let successViewController = viewControllerFactory.createSuccessViewController()
        navigationController.pushViewController(successViewController, animated: true)
    }
}
