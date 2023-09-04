import UIKit

protocol CoordinatorProtocol {
    var navigationController: UINavigationController { get set }
    
    func start()
}
