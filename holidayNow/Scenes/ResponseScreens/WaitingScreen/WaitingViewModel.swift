import UIKit

final class WaitingViewModel: WaitingViewModelProtocol {
    
    private var texts = [
        L10n.ResultScreen.WaitingText.var1,
        L10n.ResultScreen.WaitingText.var2,
        L10n.ResultScreen.WaitingText.var3
    ]
    
    private var images = [
                    Resources.Images.ResponseScreens.responseWaitingFirst,
                    Resources.Images.ResponseScreens.responseWaitingSecond
                ]
    
    func getRandomText() -> String {
        texts.randomElement() ?? L10n.ResultScreen.WaitingText.var1
    }
    
    func getRandomImage() -> UIImage {
        images.randomElement() ?? Resources.Images.ResponseScreens.responseWaitingFirst
    }
}