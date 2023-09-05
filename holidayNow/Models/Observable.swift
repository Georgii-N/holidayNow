import Foundation

@propertyWrapper
final class Observable<Value> {
    private var onChange: ((Value) -> Void)?
    
    var wrappedValue: Value {
        didSet {
            onChange?(wrappedValue)
        }
    }
    
    var projetedValue: Observable<Value>{
        return self
    }
    
    init(wrapperValue: Value) {
        self.wrappedValue = wrapperValue
    }
    
    func bind(action: @escaping (Value) -> Void) {
        self.onChange = action
    }
}
