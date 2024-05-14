//  MoodMeMoustaches

import UIKit

func customRGBColor(
    red: CGFloat,
    green: CGFloat,
    blue: CGFloat,
    alpha: CGFloat = 1
) -> UIColor {
    let red = CGFloat(red) / 255.0  // Replace 255 with your desired red value (0-255)
    let green = CGFloat(green) / 255.0  // Replace 0 with your desired green value (0-255)
    let blue = CGFloat(blue) / 255.0 // Replace 128 with your desired blue value (0-255)
    let alphaColor = CGFloat(alpha)
    
    let customColor = UIColor(red: red, green: green, blue: blue, alpha: alphaColor)
    
    return customColor
}
