import UIKit

final class BaseWarningLabel: UILabel {
    
    // MARK: - Constants and Variables:
    private var labelText: String
    
    // MARK: - Lifecycle:
    init(with text: String) {
        self.labelText = text
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Views:
extension BaseWarningLabel {
    private func setupViews() {
        font = .captionExtraSmallRegularFont
        textColor = .universalRed
        text = labelText
    }
}
