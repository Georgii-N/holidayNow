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
        
        enum SecondForm {
            static let birthday = UIImage(named: "cake") ?? UIImage()
            static let newYear = UIImage(named: "forest") ?? UIImage()
            static let mensDay = UIImage(named: "man_3") ?? UIImage()
            static let womensDay = UIImage(named: "spa") ?? UIImage()
            static let cute = UIImage(named: "volunteer_activism") ?? UIImage()
            static let gentle = UIImage(named: "cake") ?? UIImage()
            static let kind = UIImage(named: "self_improvement") ?? UIImage()
            static let sensual = UIImage(named: "interests") ?? UIImage()
            static let respectful = UIImage(named: "thumb_up_alt") ?? UIImage()
            static let funny = UIImage(named: "mood") ?? UIImage()
            static let creative = UIImage(named: "emoji_objects") ?? UIImage()
            static let bold = UIImage(named: "whatshot") ?? UIImage()
            static let witty = UIImage(named: "psychology") ?? UIImage()
        }
        
        enum ResponseScreens {
            static let responseAIError = UIImage(named: "response_ai_error") ?? UIImage()
            static let responseNetworkError = UIImage(named: "response_network_error") ?? UIImage()
            static let responseSuccess = UIImage(named: "response_success") ?? UIImage()
            static let responseWaitingFirst = UIImage(named: "response_waiting_ver1") ?? UIImage()
            static let responseWaitingSecond = UIImage(named: "response_waiting_ver2") ?? UIImage()
        }
        
        enum CollectionCell {
            static let enterButton = UIImage(systemName: "plus")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage()
        }
    }
    
    enum URLs {
        static let defaultURL = "https://api.deepai.org/api/text-generator"
    }
    
    enum API {
        static let deepAI = "13fc0b0b-50a8-4acd-8ced-0ad045c64746"
    }
    
    enum Identifiers {
        // Cells:
        static let formInterestCollectionVewCell = "FirstFormCollectionViewCell"
        static let formEnterInterestCollectionVewCell = "FirstFormEnterInterestCell"
        
        // Reusable view:
        static let collectionReusableView = "FirstFormReusableView"
    }
}
