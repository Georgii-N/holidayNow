import Foundation

final class SuccessViewModel: SuccessViewModelProtocol {
    
    // MARK: - Observable Values:
    var textResultObservable:
    Observable<String?> {
        $textResult
    }
    
    @Observable
    private var textResult: String?
    
    init(textResult: String) {
        self.textResult = textResult
        
    }
}
