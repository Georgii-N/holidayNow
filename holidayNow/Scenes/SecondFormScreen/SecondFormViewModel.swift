import Foundation

final class SecondFormViewModel: SecondFormViewModelProtocol {
    
    // MARK: - Dependencies:
    weak var dataProvider: DataProviderProtocol?
    
    // MARK: - Constants and Variables:
    var intonations = Intonation(name: L10n.SecondForm.greetingsIntonation, intonations: [
        IntonationsTarget(name: L10n.SecondForm.cute, image: Resources.Images.SecondForm.cute),
        IntonationsTarget(name: L10n.SecondForm.gentle, image: Resources.Images.SecondForm.gentle),
        IntonationsTarget(name: L10n.SecondForm.kind, image: Resources.Images.SecondForm.gentle),
        IntonationsTarget(name: L10n.SecondForm.sensual, image: Resources.Images.SecondForm.sensual),
        IntonationsTarget(name: L10n.SecondForm.respectful, image: Resources.Images.SecondForm.respectful),
        IntonationsTarget(name: L10n.SecondForm.funny, image: Resources.Images.SecondForm.funny),
        IntonationsTarget(name: L10n.SecondForm.creative, image: Resources.Images.SecondForm.creative),
        IntonationsTarget(name: L10n.SecondForm.bold, image: Resources.Images.SecondForm.bold),
        IntonationsTarget(name: L10n.SecondForm.witty, image: Resources.Images.SecondForm.witty)
    ])
    
    private var selectedHoliday: String?
    private var selectedIntonation: String?
    
    // MARK: - Observable Values:
    var holidaysObserver: Observable<Holiday> {
        $holidays
    }
    
    @Observable
    private(set) var holidays = Holiday(name: L10n.SecondForm.greetingsName, holidays: [
        HolidaysTarget(name: L10n.SecondForm.happyBirthday, image: Resources.Images.SecondForm.birthday),
        HolidaysTarget(name: L10n.SecondForm.newYear, image: Resources.Images.SecondForm.newYear),
        HolidaysTarget(name: L10n.SecondForm.mensDay, image: Resources.Images.SecondForm.mensDay),
        HolidaysTarget(name: L10n.SecondForm.womensDay, image: Resources.Images.SecondForm.womensDay),
    ])
    
    // MARK: - Lifecycle:
    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    // MARK: - Public Methods:
    func setupHoliday(name: String?) {
        selectedHoliday = name
    }
    
    func setupIntonation(name: String?) {
        selectedIntonation = name
    }
    
    func addNewHoliday(with name: String) {
        holidays.holidays.append(HolidaysTarget(name: name, image: Resources.Images.SecondForm.birthday))
    }
    
    func sentGreetingsInfo() {
        if let selectedHoliday {
            dataProvider?.setHoliday(holiday: selectedHoliday)
        }
        
        if let selectedIntonation {
            dataProvider?.setIntonation(intonation: selectedIntonation)
        }
    }
}
