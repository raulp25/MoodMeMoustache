//  MoodMeMoustaches

import UIKit

extension CustomButton {
    struct ViewModel {
        enum ButtonType {
            case `default`
            case secondary
            case transparent
        }

        var buttonType: ButtonType
        var title: String

        init(title: String, buttonType: ButtonType = .default) {
            self.title = title
            self.buttonType = buttonType
        }

        var backgroundColor: UIColor? {
            switch buttonType {
            case .default:
//                return .theme.button
                return UIColor.orange
            case .secondary:
                return .clear
            case .transparent:
                return .clear
            }
        }

        var textColor: UIColor? {
            switch buttonType {
            case .default:
//                return .theme.buttonText
                return .white
            case .secondary:
//                return .theme.tintColor
                return .green
            case .transparent:
                return customRGBColor(red: 243, green: 117, blue: 121)
            }
        }

        var borderColor: UIColor? {
            switch buttonType {
            case .default:
                return nil
            case .secondary:
//                return .theme.border
                return .red
            case .transparent:
                return customRGBColor(red: 243, green: 117, blue: 121)
            }
        }

        var borderWidth: CGFloat {
            switch buttonType {
            case .default:
                return 0
            case .secondary:
                return 1
            case .transparent:
                return 1
            }
        }
    }
}

