import UIKit

protocol CoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController { get set }
    var viewControllerFactory: ViewControllerFactoryProtocol { get set }
    
    func start()
    func goToSuccessResultViewController()
    func goToCongratulationTypeViewController()
}
