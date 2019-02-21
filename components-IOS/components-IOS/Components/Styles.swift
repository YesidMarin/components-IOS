//
//  Styles.swift
//  components-IOS
//
//  Created by Yesid Marin on 2/21/19.
//  Copyright © 2019 UpperDev. All rights reserved.
//

import Foundation
import UIKit

struct DefaultSystemComponents {
    static let defaultPaddingTextFieldAndButtons = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
    static let defaultTextFieldHeight = CGFloat(48)
}

struct TextFieldProperties {
    let cursorColor: UIColor
    let fontSize: CGFloat
    let fontWeight: UIFont.Weight
    let placeHolderColor: UIColor
    let textColor: UIColor
    let backgroundColor: UIColor
}

enum TextFieldStyle {
    
    case medium
    
    var properties: TextFieldProperties {
        switch self {
        case .medium:
            return TextFieldProperties(cursorColor: .black, fontSize: 15, fontWeight: UIFont.Weight.regular, placeHolderColor: Colors.lightGray, textColor: Colors.blueGray, backgroundColor: Colors.backgroundGray)
        }
    }
}
