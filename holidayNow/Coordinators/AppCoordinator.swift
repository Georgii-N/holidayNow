import UIKit

final class AppCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var viewControllerFactory: ViewControllerFactoryProtocol
    
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllerFactoryProtocol) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    func start() {
        let onboardingViewController = viewControllerFactory.createOnboardingViewController()
        navigationController.pushViewController(onboardingViewController, animated: true)
    }
    
    func goToSuccessResultViewController() {
        let successViewController = viewControllerFactory.createSuccessViewController()
        navigationController.pushViewController(successViewController, animated: true)
    }
}
