import UIKit
import Amplitude

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Amplitude.instance().initializeApiKey("5166bb136a4e6148b573f7c585315038")
        
        let navigationController = UINavigationController()
        
        let networkClient = NetworkClient(apiKey: Resources.API.deepAI)
        let greetingRequestFactory = GreetingRequestFactory()
        
        let dataProvider = DataProvider(networkClient: networkClient, greetingRequestFactory: greetingRequestFactory)
        
        let viewControllerFactory = ViewControllerFactory(dataProvider: dataProvider)
        coordinator = AppCoordinator(navigationController: navigationController, viewControllerFactory: viewControllerFactory)
        viewControllerFactory.coordinator = coordinator
        
        if let coordinator {
            let enteringService = EnteringService()
            if enteringService.isFirstEntering == nil {
                coordinator.start()
                enteringService.setupNewValue()
            } else {
                coordinator.goToFirstFormViewController()
            }
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
