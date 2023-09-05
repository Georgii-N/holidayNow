import Foundation

final class FirstFormViewModel: FirstFormViewModelProtocol {
    
    // MARK: - Constants and Variables:
    private var selectedInterests: [GreetingTarget] = []
    
    // MARK: - Observable Values:
    var userNameObservable: Observable<String?> {
        $userName
    }
    
    var interestsObservable: Observable<[Interests]> {
        $interests
    }
    
    @Observable
    private var userName: String?
    
    @Observable
    private(set) var interests = [
        Interests(name: L10n.FirstForm.Interests.title, interests: [
            GreetingTarget(image: Resources.Images.cooking, name: L10n.FirstForm.Interests.cooking),
            GreetingTarget(image: Resources.Images.sport, name: L10n.FirstForm.Interests.sport),
            GreetingTarget(image: Resources.Images.movies, name: L10n.FirstForm.Interests.movies),
            GreetingTarget(image: Resources.Images.travelling, name: L10n.FirstForm.Interests.travelling),
            GreetingTarget(image: Resources.Images.boardGames, name: L10n.FirstForm.Interests.boardGames),
            GreetingTarget(image: Resources.Images.nature, name: L10n.FirstForm.Interests.nature),
            GreetingTarget(image: Resources.Images.music, name: L10n.FirstForm.Interests.music),
            GreetingTarget(image: Resources.Images.theatre, name: L10n.FirstForm.Interests.theatre),
            GreetingTarget(image: Resources.Images.videoGames, name: L10n.FirstForm.Interests.videoGames),
            GreetingTarget(image: Resources.Images.animals, name: L10n.FirstForm.Interests.animals),
            GreetingTarget(image: Resources.Images.tastyFood, name: L10n.FirstForm.Interests.tastyFoods),
            GreetingTarget(image: Resources.Images.programming, name: L10n.FirstForm.Interests.programming)
        ])
    ]
    
    // MARK: - Public Methods:
    func setupUsername(_ name: String?) {
        if name == nil || name == "" {
            userName = nil
        } else {
            userName = name
        }
    }
    
    func controlInterestState(isAdd: Bool, interest: GreetingTarget) {
        if isAdd {
            selectedInterests.append(interest)
        } else {
            if let index = selectedInterests.firstIndex(where: { $0.name == interest.name }) {
                selectedInterests.remove(at: index)
            }
        }
    }
}
