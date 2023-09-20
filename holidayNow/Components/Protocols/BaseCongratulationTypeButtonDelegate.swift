import Foundation

protocol BaseCongratulationTypeButtonDelegate: AnyObject {
    func synchronizeOtherButtons(title: String, state: Bool, buttonType: BaseCongratulationButtonState)
}
