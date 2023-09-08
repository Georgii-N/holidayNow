import UIKit

protocol WaitingViewModelProtocol {
    var isResponseSuccessObservable: Observable<Bool?> { get }
    
    func getRandomText() -> String
    func getRandomImage() -> UIImage
}
