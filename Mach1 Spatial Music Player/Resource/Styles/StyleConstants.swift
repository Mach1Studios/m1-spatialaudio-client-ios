import SwiftUI

enum Mach1Margin: CGFloat {
    case VBig = 24.0
    case Big = 16.0
    case Normal = 12.0
    case Small = 8.0
}

enum Mach1Font: String {
    case Regular = "ProximaNova-Regular"
    case RegularItalic = "ProximaNova-RegularIt"
    case Medium = "ProximaNova-Medium"
    case SemiBold = "ProximaNova-SemiBold"
}

enum Mach1TextSize: CGFloat {
    case Large = 16.0
    case Medium = 14.0
    case Small = 12.0
    case VerySmall = 10.0
}

struct Constants {
    
    struct Dimension {
        static let progressBar: CGFloat = 100.0
    }
    
    struct Rounded {
        static let value: CGFloat = 8.0
    }
    
    struct LineWidtch {
        static let value: CGFloat = 0.4
    }
    
    struct Fonts {
        static let title: Font = .custom(Mach1Font.SemiBold.rawValue, size: Mach1TextSize.Large.rawValue)
        static let subTitleBold: Font = .custom(Mach1Font.SemiBold.rawValue, size: Mach1TextSize.Medium.rawValue)
        static let subTitle: Font = .custom(Mach1Font.Medium.rawValue, size: Mach1TextSize.Medium.rawValue)
        static let body: Font = .custom(Mach1Font.Regular.rawValue, size: Mach1TextSize.Medium.rawValue)
        static let subBody: Font = .custom(Mach1Font.Regular.rawValue, size: Mach1TextSize.Small.rawValue)
        static let smallBody: Font = .custom(Mach1Font.Regular.rawValue, size: Mach1TextSize.VerySmall.rawValue)
    }
    
    struct Image {
        enum Dimension: CGFloat {
            case VeryBig = 300
            case Big = 120
            case Normal = 60
        }
        enum Default: String {
            case Person = "person.fill"
            case Track = "music.note.list"
            case PlayList = "DefaultPlaylist"
        }
        enum System: String {
            case CheckMark = "checkmark" // 􀆅
            case Person = "person.crop.circle" // 􀉭
            case NotFavourite = "heart" // 􀊴
            case Favourite = "heart.fill" // 􀊵
            case Favourites = "heart.circle" // 􀊸
            case Option = "option" // 􀆕
            case Shuffle = "shuffle.circle" // 􀵉
            case Repeat = "repeat.circle" // 􀵋
            case Play = "play.fill" // 􀊄
            case Friends = "person.2.circle" // 􀠃
            case Add = "plus.circle" // 􀁌
            case Edit = "pencil.circle" // 􀈋
            case QuestionMark = "questionmark.circle" // 􀁜
            case RemovePerson = "person.crop.circle.badge.xmark" // 􀉵
            case Camera = "camera.circle.fill" // 􀌡
            case Navigate = "chevron.forward" // 􀯻
            case PreviousTrack = "backward.circle" // 􀺃
            case NextTrack = "forward.circle" // 􀺅
            case PlayTrack = "play.circle" // 􀊕
            case PauseTrack = "pause.circle" // 􀊗
            case Logout = "escape" // 􀆧
        }
    }
    
    struct Blur {
        static let value: CGFloat = 1.1
    }
    
    struct Shadow {
        static let value: CGFloat = 2
    }
    
}
