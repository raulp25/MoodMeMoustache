//  MoodMeMoustaches

import UIKit

// MARK: - SF Symbol Button
public extension UIButton {
    
    static func createIconButton(
        icon: String,
        size: CGFloat = 17,
        color: UIColor? = nil,
        weight: UIImage.SymbolWeight = .medium
    )
        -> UIButton {
        let button = IncreaseTapAreaButton()

        let config = UIImage.SymbolConfiguration(pointSize: size, weight: weight)
        let iconImage = UIImage(
            systemName: icon,
            withConfiguration: config
        )?.withTintColor(
            color ?? UIColor.black,
            renderingMode: .alwaysOriginal
        )
        button.setImage(iconImage, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        //button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    func updateIcon(
        newIcon: String,
        newColor: UIColor? = nil,
        newWeight: UIImage.SymbolWeight = .medium,
        newSize: CGFloat = 17
    ) {
        let config = UIImage.SymbolConfiguration(pointSize: newSize, weight: newWeight)
        let iconImage = UIImage(
            systemName: newIcon,
            withConfiguration: config
        )?.withTintColor(
            newColor ?? UIColor.black,
            renderingMode: .alwaysOriginal
        )
        setImage(iconImage, for: .normal)
    }
}

extension UIButton {
    final class IncreaseTapAreaButton: UIButton {
        // MARK: - Increase tappable area
        override func point(inside point: CGPoint, with _: UIEvent?) -> Bool {
            return bounds.insetBy(dx: -15, dy: -15).contains(point)
        }
    }
}

extension UIButton {
    func setImageTintColor(_ color: UIColor) {
        let tintedImage = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedImage, for: .normal)
        self.tintColor = color
    }
}

// MARK: - TextButton
public extension UIButton {
    static func createTextButton(with buttonText: String, fontSize: CGFloat? = nil, color: UIColor? = nil) -> UIButton {
        let button = UIButton(frame: .zero)
        button.setTitle(buttonText, for: .normal)
        button.setTitleColor( color ?? .black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: fontSize ?? 15, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    static func createSecondaryButton(with buttonText: String) -> UIButton {
        let button = createTextButton(with: buttonText)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.purple.cgColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 3

        guard let titleLabel = button.titleLabel else {
            fatalError("Title label constraint error in createSecondaryButton")
        }

        button.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -10).isActive = true
        button.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        return button
    }
}

public extension UIButton {
    //Todo Add color prop to theme enum
    static func createCustomIconImage(customIcon: String, size: CGFloat, color: UIColor = UIColor.gray.withAlphaComponent(0.8)) -> UIButton {
        let button = UIButton()
        if let image = UIImage(systemName: customIcon)?.withRenderingMode(.alwaysOriginal) {
            button.setImage(image, for: .normal)
            button.setImageTintColor(color)
        }

        button.heightAnchor.constraint(equalToConstant: size).isActive = true
        button.widthAnchor.constraint(equalToConstant: size).isActive = true
        return button
    }
}

