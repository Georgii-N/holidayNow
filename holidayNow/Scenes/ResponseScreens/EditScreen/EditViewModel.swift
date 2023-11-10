import Foundation

final class EditViewModel: EditViewModelProtocol {
    
    // MARK: - Dependencies
    private var dataProvider: DataProviderProtocol
    
    // MARK: - Constants and Variables:
    private var resultText: String
    
    // MARK: - LifeCycle:
    init(resultText: String, dataProvider: DataProviderProtocol) {
        self.resultText = resultText
        self.dataProvider = dataProvider
    }
    
    // MARK: - Public Methods:
    func getResultText() -> String {
        resultText
    }
    
    func setResultTextAfterEdit(text: String) {
        dataProvider.setResultTextAfterEdit(resultText: text)
    }
}
