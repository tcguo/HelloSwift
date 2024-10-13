//
//  Color+YT.swift
//  HelloSwift
//
//  Created by gtc on 2021/7/1.
//

import UIKit
public extension UIColor {
    
    // Hex String -> UIColor
    convenience init(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    // UIColor -> Hex String
    var hexString: String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        let multiplier = CGFloat(255.999999)
        
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        
        if alpha == 1.0 {
            return String(
                format: "#%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        }
        else {
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }
    
    
    static let ColorBABABA = UIColor(hexString: "#BABABA")
    static let ColorFF9020 = UIColor(hexString: "#FF9020")
    static let ColorFF557E = UIColor(hexString: "#FF557E")
    static let ColorEBEBEB = UIColor(hexString: "#EBEBEB")
    static let ColorF4F4F4 = UIColor(hexString: "#F4F4F4")
    static let ColorFF74B6 = UIColor(hexString: "#FF74B6")
    static let ColorFFE5F3 = UIColor(hexString: "#FFE5F3")
    static let COlor272727 = UIColor(hexString: "#272727")
    
    
}

