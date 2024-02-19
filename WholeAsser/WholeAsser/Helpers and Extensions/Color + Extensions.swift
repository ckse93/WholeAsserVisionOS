//
//  Color + Extensions.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/12/24.
//

import Foundation
import SwiftUI
import UIKit


/// main: background
/// popDark/Pale: Highly legible
/// accentDark/Pale: accent color
struct ColorPackage {
    let main: Color
    let popDark: Color
    let popPale: Color
    let accentDark: Color
    let accentPale: Color
}

struct ColorSet {
    let base: ColorPackage
    let complimentary: ColorPackage
}

//  https://stackoverflow.com/questions/56466128/what-are-the-primary-and-secondary-colors-in-swiftui
extension Color {
    
    static let appTintColor = Color.systemOrange
     
    // MARK: - Text Colors
    static let lightText = Color(UIColor.lightText)
    static let darkText = Color(UIColor.darkText)
    static let placeholderText = Color(UIColor.placeholderText)

    // MARK: - Label Colors
    static let label = Color(UIColor.label)
    static let secondaryLabel = Color(UIColor.secondaryLabel)
    static let tertiaryLabel = Color(UIColor.tertiaryLabel)
    static let quaternaryLabel = Color(UIColor.quaternaryLabel)

    // MARK: - Background Colors
    static let systemBackground = Color(UIColor.systemBackground)
    static let secondarySystemBackground = Color(UIColor.secondarySystemBackground)
    static let tertiarySystemBackground = Color(UIColor.tertiarySystemBackground)
    
    // MARK: - Fill Colors
    static let systemFill = Color(UIColor.systemFill)
    static let secondarySystemFill = Color(UIColor.secondarySystemFill)
    static let tertiarySystemFill = Color(UIColor.tertiarySystemFill)
    static let quaternarySystemFill = Color(UIColor.quaternarySystemFill)
    
    // MARK: - Grouped Background Colors
    static let systemGroupedBackground = Color(UIColor.systemGroupedBackground)
    static let secondarySystemGroupedBackground = Color(UIColor.secondarySystemGroupedBackground)
    static let tertiarySystemGroupedBackground = Color(UIColor.tertiarySystemGroupedBackground)
    
    // MARK: - Gray Colors
    static let systemGray = Color(UIColor.systemGray)
    static let systemGray2 = Color(UIColor.systemGray2)
    static let systemGray3 = Color(UIColor.systemGray3)
    static let systemGray4 = Color(UIColor.systemGray4)
    static let systemGray5 = Color(UIColor.systemGray5)
    static let systemGray6 = Color(UIColor.systemGray6)
    
    // MARK: - Other Colors
    static let separator = Color(UIColor.separator)
    static let opaqueSeparator = Color(UIColor.opaqueSeparator)
    static let link = Color(UIColor.link)
    
    // MARK: System Colors
    static let systemBlue = Color(UIColor.systemBlue)
    static let systemPurple = Color(UIColor.systemPurple)
    static let systemGreen = Color(UIColor.systemGreen)
    static let systemYellow = Color(UIColor.systemYellow)
    static let systemOrange = Color(UIColor.systemOrange)
    static let systemPink = Color(UIColor.systemPink)
    static let systemRed = Color(UIColor.systemRed)
    static let systemTeal = Color(UIColor.systemTeal)
    static let systemIndigo = Color(UIColor.systemIndigo)
    
    // MARK: Gradient Color Presents
    static let defaultGradientStart = Color.orange
    static let defaultGradientEnd = Color(hex: "FF592C")
    
    static let assGradientStart = Color(hex: "ef4137")
    static let assGradientEnd = Color(hex: "f68e5b")
    
    static let tangerine = Color(hex: "ed732e")
    static let rosePetal = Color(hex: "d44a7a")
    
    static let skyBlueDark = Color(hex: "5ab2f7")
    static let skyBlueLight = Color(hex: "12cff3")
    
    static let skyBlueDarkDark = Color(hex: "2278fb")
    static let skyTeal = Color(hex: "6bdfdb")
    
    static let boraPurple = Color(hex: "ea98da")
    static let boraBlue = Color(hex: "5b6cf9")
    
    static let bisexualPurpleDark = Color(hex: "392d69")
    static let bisexualPurpleLight = Color(hex: "b57bee")
    
    static let moldGreen = Color(hex: "51c26f")
    static let moldLemon = Color(hex: "f2e901")
    
    static let offBrandMustard = Color(hex: "ffcb6b")
    static let randomlyPickBlue = Color(hex: "3d8bff")
    
    static let mushroom = Color(hex: "e8b595")
    static let disneyVillainEyeshadowPurple = Color(hex: "b190ba")
}

extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        print(cleanHexCode)
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}

extension Color {
    func toHex() -> String? {
        // Convert Color to UIColor
        let uiColor = UIColor(self)
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        // Extract RGBA components
        guard uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil // Return nil if unable to extract components
        }
        
        // Convert components to hex string
        let hexString = String(format: "#%02lX%02lX%02lX",
                               lroundf(Float(red) * 255),
                               lroundf(Float(green) * 255),
                               lroundf(Float(blue) * 255))
        return hexString
    }
}
