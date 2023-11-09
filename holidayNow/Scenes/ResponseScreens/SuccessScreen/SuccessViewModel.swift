import Foundation

final class SuccessViewModel: SuccessViewModelProtocol {
    // MARK: - Dependencies
    private var dataProvider: DataProviderProtocol
    
    // MARK: - Observable Values:
    var textResultObservable:
    Observable<String?> {
        $textResult
    }
    
    @Observable
    private(set) var textResult: String?
    
    // MARK: - Lifecycle:
    init(textResult: String, dataProvider: DataProviderProtocol) {
        self.textResult = textResult
        self.dataProvider = dataProvider
    }
    
    // MARK: - Public Function:
    func getResultText() {
        self.textResult = dataProvider.getResultText()
    }
}
