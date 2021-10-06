import SwiftUI

enum Mach1Margin: CGFloat {
    case VVBig = 44.0
    case VBig = 24.0
    case Big = 16.0
    case Normal = 14.0
    case Small = 8.0
    case VSmall = 4.0
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
    
    enum Dimension: CGFloat {
        case progressBar = 100.0
        case orientationCard = 200.0
    }
    
    enum Rounded: CGFloat {
        case normal = 4.0
        case none = 0.0
    }
    
    struct LineWidth {
        static let thick: CGFloat = 1.0
        static let normal: CGFloat = 0.4
    }
    
    struct LineDashedLength {
        static let normal: CGFloat = 4
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
            case Small = 40
            case TabIcon = 30
        }
        enum Default: String {
            case Person = "person.fill"
            case Track = "music.note.list"
            case PlayList = "DefaultPlaylist"
        }
        enum System: String {
            case Back = "chevron.backward" // 􀯶
            case CheckMark = "checkmark" // 􀆅
            case Person = "person.crop.circle" // 􀉭
            case NotFavourite = "heart" // 􀊴
            case Favourite = "heart.fill" // 􀊵
            case Favourites = "heart.circle" // 􀊸
            case Option = "option" // 􀆕
            case Shuffle = "shuffle" // 􀊝
            case Repeat = "repeat" // 􀊞
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
        enum Custom: String {
            case Mach1Logo = "Logo"
            case Mach1LogoTabItem = "LogoTabItem"
        }
    }
    
    struct Shadow {
        static let value: CGFloat = 2
    }
    
    struct Opacity {
        static let value: CGFloat = 0.6
    }
    
    struct OrientationCardAspectRatio {
        static let value: CGFloat = 9 / 21
    }
    
}
