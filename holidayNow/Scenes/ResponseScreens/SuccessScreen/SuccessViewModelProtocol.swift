import Foundation

protocol SuccessViewModelProtocol {
    var textResultObservable: Observable<String?> { get }
}
