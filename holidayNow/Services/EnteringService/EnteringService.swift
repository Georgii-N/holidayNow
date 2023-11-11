import Foundation

final class EnteringService {
    
    // MARK: - Classes:
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Constants and Variables:
    var countOfOpening: Int {
        countOfOpen
    }
    
    var isFirstEntering: Bool? {
        isFirstEnter
    }
    
    private var isFirstEnter: Bool? {
        get {
            userDefaults.value(forKey: Resources.UserDefaults.key) as? Bool ?? nil
        } set {
            userDefaults.set(newValue, forKey: Resources.UserDefaults.key)
        }
    }
    
    private var countOfOpen: Int {
        get {
            userDefaults.value(forKey: Resources.UserDefaults.openingKey) as? Int ?? 0
        } set {
            userDefaults.set(newValue, forKey: Resources.UserDefaults.openingKey)
        }
    }
    
    // MARK: - Public Methods:
    func setupNewValue() {
        isFirstEnter = true
    }
    
    func incrementCountOfOpening() {
        countOfOpen += 1
        print("countOfOpening: \(countOfOpening)")
    }
}
