import UIKit
import AmplitudeSwift
import AppTrackingTransparency

@main
    class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationController = UINavigationController()
        
        let networkClient = NetworkClient(apiKey: Resources.API.deepAI)
        
        let dataProvider = DataProvider(networkClient: networkClient)
        
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
                enteringService.incrementCountOfOpening()
            }
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        requestTrackingAuthorization()
    }
    
    private func requestTrackingAuthorization() {
        guard #available(iOS 14.5, *) else { return }
        ATTrackingManager.requestTrackingAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    print("Доступ одобрен.")
                case .denied, .restricted:
                    print("Пользователь запретил доступ.")
                case .notDetermined:
                    print("Пользователь ещё не получил запрос на авторизацию.")
                @unknown default:
                    break
                }
            }
        }
    }
}
