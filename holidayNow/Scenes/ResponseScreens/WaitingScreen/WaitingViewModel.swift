import UIKit

final class WaitingViewModel: WaitingViewModelProtocol {
    
    // MARK: - Dependencies
    private var dataProvider: DataProviderProtocol
    
    // MARK: - Constants and Variables
    private var texts = [
        L10n.ResultScreen.WaitingText.var1,
        L10n.ResultScreen.WaitingText.var2,
        L10n.ResultScreen.WaitingText.var3
    ]
    
    private var images = [
                    Resources.Images.ResponseScreens.responseWaitingFirst,
                    Resources.Images.ResponseScreens.responseWaitingSecond
                ]
    
    private var responseText: String?
   
    // MARK: - Observable Values:
    var isResponseSuccessObservable: Observable<Bool?> {
        $isResponseSuccess
    }
    
    @Observable
    private(set) var isResponseSuccess: Bool?
    
    // MARK: - Lifecycle
    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
        
        dataProvider.createRequestText { [weak self ] result in
            guard let self else { return }
            switch result {
            case .success:
                self.isResponseSuccess = true
                
            case .failure(let error):
                self.isResponseSuccess = false
                assertionFailure(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Public Methods
    func getRandomText() -> String {
        texts.randomElement() ?? L10n.ResultScreen.WaitingText.var1
    }
    
    func getRandomImage() -> UIImage {
        images.randomElement() ?? Resources.Images.ResponseScreens.responseWaitingFirst
    }
}
