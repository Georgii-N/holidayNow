import Foundation

final class FirstFormViewModel: FirstFormViewModelProtocol {
    
    // MARK: - Dependencies:
    weak var dataProvider: DataProviderProtocol?
    
    // MARK: - Constants and Variables:
    var cellImages = [
        Resources.Images.OwnCell.star,
        Resources.Images.SecondForm.respectful,
        Resources.Images.SecondForm.funny
    ]
    
    private(set) var indexToRemoveCell: Int?
    private var ownCellCounter = 0
   
    // MARK: - Observable Values:
    var userNameObservable: Observable<String?> {
        $userName
    }
    
    var interestsObservable: Observable<Interest> {
        $interests
    }
    
    var selectedInterestsObservable: Observable<[GreetingTarget]> {
        $selectedInterests
    }
    
    @Observable
    private var userName: String?
    
    @Observable
    private(set) var interests = Interest(name: L10n.FirstForm.Interests.title, interests: [
        GreetingTarget(name: L10n.FirstForm.Interests.cooking, image: Resources.Images.FirstForm.cooking),
        GreetingTarget(name: L10n.FirstForm.Interests.sport, image: Resources.Images.FirstForm.sport),
        GreetingTarget(name: L10n.FirstForm.Interests.movies, image: Resources.Images.FirstForm.movies),
        GreetingTarget(name: L10n.FirstForm.Interests.travelling, image: Resources.Images.FirstForm.travelling),
        GreetingTarget(name: L10n.FirstForm.Interests.boardGames, image: Resources.Images.FirstForm.boardGames),
        GreetingTarget(name: L10n.FirstForm.Interests.nature, image: Resources.Images.FirstForm.nature),
        GreetingTarget(name: L10n.FirstForm.Interests.music, image: Resources.Images.FirstForm.music),
        GreetingTarget(name: L10n.FirstForm.Interests.theatre, image: Resources.Images.FirstForm.theatre),
        GreetingTarget(name: L10n.FirstForm.Interests.videoGames, image: Resources.Images.FirstForm.videoGames),
        GreetingTarget(name: L10n.FirstForm.Interests.animals, image: Resources.Images.FirstForm.animals),
        GreetingTarget(name: L10n.FirstForm.Interests.tastyFoods, image: Resources.Images.FirstForm.tastyFood),
        GreetingTarget(name: L10n.FirstForm.Interests.programming, image: Resources.Images.FirstForm.programming)
    ])
    
    @Observable
    private(set) var selectedInterests: [GreetingTarget] = []
    
    // MARK: - Lifecycle:
    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    // MARK: - Public Methods:
    func setupUsername(_ name: String?) {
        userName = name == "" ? nil : name
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
    
    func addNewOwnInterest(name: String) {
        let index = interests.interests.count
        interests.interests.insert(GreetingTarget(name: name, image: cellImages[ownCellCounter]), at: index)
        ownCellCounter += 1
    }
    
    func removeOwnInterest(from index: Int) {
        ownCellCounter -= 1
        indexToRemoveCell = index
        controlInterestState(isAdd: false, interest: interests.interests[index])
        interests.interests.remove(at: index)
    }
    
    func sentInterests() {
        var interestsName: [String] = []
        
        if let userName {
            dataProvider?.setName(name: userName)
        }
        
        if !selectedInterests.isEmpty {
            selectedInterests.forEach { interestsName.append($0.name) }
            dataProvider?.setInterests(interests: interestsName)
        }
    }
}
