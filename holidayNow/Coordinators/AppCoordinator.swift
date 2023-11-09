import UIKit

final class AppCoordinator: CoordinatorProtocol {
    
    // MARK: - Constants and Variables
    private var navigationController: UINavigationController
    private var viewControllerFactory: ViewControllerFactoryProtocol
    
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
    
    func goToSecondFormViewController() {
        let secondFormViewController = viewControllerFactory.createSecondFormViewController()
        navigationController.pushViewController(secondFormViewController, animated: true)
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
    
    func presentEditViewController(presenter: UIViewController) {
        let editViewController = viewControllerFactory.createEditViewController()
        presenter.present(editViewController, animated: true)
    }
    
    // Pop:
    func goBack() {
        navigationController.popViewController(animated: true)
    }
    
    func removeAllviewControllers() {
        navigationController.viewControllers.removeAll { $0 != $0 as? FirstFormViewController }
    }
}
