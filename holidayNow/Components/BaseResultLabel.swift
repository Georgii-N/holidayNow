import UIKit

final class BaseResultLabel: UILabel {
    
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        self.font = .bodyExtraLargeBoldFont
        self.textColor = .blackDay
        self.textAlignment = .center
        self.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
