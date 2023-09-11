import Foundation

final class EnteringService {
    
    var isFirstEntering: Bool? {
        isFirstEnter
    }
    
    private let userDefaults = UserDefaults.standard
    
    private var isFirstEnter: Bool? {
        get {
            userDefaults.value(forKey: "isFirstEnter") as? Bool ?? nil
        } set {
            userDefaults.set(newValue, forKey: "isFirstEnter")
        }
    }
    
    func setupNewValue() {
        isFirstEnter = true
    }
}
