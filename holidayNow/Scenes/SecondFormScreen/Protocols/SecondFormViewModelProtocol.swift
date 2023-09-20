import Foundation

protocol SecondFormViewModelProtocol: AnyObject {
    var intonations: Intonation { get }
    var selectedHolidayObservable: Observable<String?> { get }
    var holidaysObserver: Observable<Holiday> { get }
    func setupHoliday(name: String?)
    func setupIntonation(name: String?)
    func addNewHoliday(with name: String)
    func sentGreetingsInfo()
}
