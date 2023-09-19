import UIKit

protocol CoordinatorProtocol: AnyObject {
    
    func start()
    func goToCongratulationTypeViewController()
    func goToFirstFormViewController()
    func goToSecondFormViewController()
    
    func goToWaitingViewController()
    func goToSuccessResultViewController()
    func goToErrorNetworkViewController()
    
    func goBack()
    func removeAllviewControllers()
}
