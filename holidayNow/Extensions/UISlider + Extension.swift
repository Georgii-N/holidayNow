import UIKit

extension UISlider {
    public func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        let pointTapped: CGPoint = sender.location(in: self)
        let viewWidht = bounds.width
        let newValue = (CGFloat((maximumValue - minimumValue)) * (pointTapped.x / (viewWidht))) + CGFloat(minimumValue)
    
        setValue(Float(newValue), animated: true)
        sendActions(for: .valueChanged)
    }
}
