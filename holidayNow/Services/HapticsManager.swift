import UIKit

final class HapticsManager {
    
    // MARK: - Public Methods:
    func vibrate() {
        DispatchQueue.main.async {
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(.error)
        }
    }
}
