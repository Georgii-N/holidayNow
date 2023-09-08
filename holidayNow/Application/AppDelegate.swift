import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = UINavigationController()
        
        let networkClient = NetworkClient(apiKey: Resources.API.deepAI)
        let greetingRequestFactory = GreetingRequestFactory()
        
        let dataProvider = DataProvider(networkClient: networkClient, greetingRequestFactory: greetingRequestFactory)
        
        let viewControllerFactory = ViewControllerFactory(dataProvider: dataProvider)
        coordinator = AppCoordinator(navigationController: navigationController, viewControllerFactory: viewControllerFactory)
        viewControllerFactory.coordinator = coordinator
        
        if let coordinator {
            coordinator.start()
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
