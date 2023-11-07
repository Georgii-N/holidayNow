import UIKit

final class BaseWarningLabel: UILabel {
    
    // MARK: - Lifecycle:
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods:
    func setupText(with text: String) {
        self.text = text
    }
}

// MARK: - Setup Views:
extension BaseWarningLabel {
    private func setupViews() {
        font = .captionSmallRegularFont
        textColor = .blackDay
    }
}
