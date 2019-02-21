//
//  Colors.swift
//  components-IOS
//
//  Created by Yesid Marin on 2/21/19.
//  Copyright © 2019 UpperDev. All rights reserved.
//

import Foundation
import UIKit

enum Colors {
    
    static let white = UIColor.white
    static let darkGray = UIColor(hexString: "434a54")
    static let secondDarkGray = UIColor(hexString: "4d4d4d")
    static let lightGray = UIColor(hexString: "BDBDBD")
    static let blueGray = UIColor(hexString: "757575")
    static let silverGray = UIColor(hexString: "efeff4")
    static let backgroundGray = UIColor(hexString: "f7f8f9")
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
