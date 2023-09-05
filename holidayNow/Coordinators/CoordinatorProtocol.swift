import UIKit

protocol CoordinatorProtocol {
    var navigationController: UINavigationController { get set }
    var viewControllerFactory: ViewControllerFactoryProtocol { get set }
    
    func start()
    func goToSuccessResultViewController()
}
