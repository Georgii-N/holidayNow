import Foundation

final class EnteringService {
    
    // MARK: - Classes:
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Constants and Variables:
    var isFirstEntering: Bool? {
        isFirstEnter
    }
    
    private var isFirstEnter: Bool? {
        get {
            userDefaults.value(forKey: "isFirstEnter") as? Bool ?? nil
        } set {
            userDefaults.set(newValue, forKey: "isFirstEnter")
        }
    }
    
    // MARK: - Public Methods:
    func setupNewValue() {
        isFirstEnter = true
    }
}
