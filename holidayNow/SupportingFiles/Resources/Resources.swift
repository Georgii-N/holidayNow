import UIKit

enum Resources {
    enum Images {
        enum NavigationBar {
            static let backButtonIcon = UIImage(named: "arrow_back") ?? UIImage()
        }
        
        enum Onboarding {
            static let onboardingImage = UIImage(named: "OnboardingImage")
        }
        
        enum FirstForm {
            static let cooking = UIImage(named: "outdoor_grill") ?? UIImage()
            static let sport = UIImage(named: "fitness_center") ?? UIImage()
            static let movies = UIImage(named: "movie_filter") ?? UIImage()
            static let travelling = UIImage(named: "local_airport") ?? UIImage()
            static let boardGames = UIImage(named: "extension") ?? UIImage()
            static let nature = UIImage(named: "volcano") ?? UIImage()
            static let music = UIImage(named: "music_note") ?? UIImage()
            static let theatre = UIImage(named: "theater_comedy") ?? UIImage()
            static let videoGames = UIImage(named: "sports_esports") ?? UIImage()
            static let animals = UIImage(named: "pets") ?? UIImage()
            static let tastyFood = UIImage(named: "ramen_dining") ?? UIImage()
            static let programming = UIImage(named: "terminal") ?? UIImage()
            static let addMyOwn = UIImage(named: "subdirectory_arrow_right") ?? UIImage()
        }
        
        enum ResponseScreens {
            static let responseAIError = UIImage(named: "response_ai_error") ?? UIImage()
            static let responseNetworkError = UIImage(named: "response_network_error") ?? UIImage()
            static let responseSuccess = UIImage(named: "response_success") ?? UIImage()
            static let responseWaitingFirst = UIImage(named: "response_waiting_ver1") ?? UIImage()
            static let responseWaitingSecond = UIImage(named: "response_waiting_ver2") ?? UIImage()
        }
    }
    
    enum URLs {
        static let defaultURL = "https://api.deepai.org/api/text-generator"
    }
    
    enum API {
        static let deepAI = "13fc0b0b-50a8-4acd-8ced-0ad045c64746"
    }
    
    enum Identifiers {
        static let firstFormInterestsCell = "FirstFormCollectionViewCell"
        static let firstFormEnterInterestCell = "firstFormEnterInterestCell"
    }
}
