import UIKit

protocol CoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController { get set }
    var viewControllerFactory: ViewControllerFactoryProtocol { get set }
    
    func start()
    func goToCongratulationTypeViewController()
    func goToFirstFormViewController()
    func goToSecondFormViewController()
    
    func goToWaitingViewController()
    func goToSuccessResultViewController()
    func goToErrorNetworkViewController()
    func goToErrorAPIViewController()
}
