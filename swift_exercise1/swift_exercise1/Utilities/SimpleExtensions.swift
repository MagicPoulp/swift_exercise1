//
//  SimpleExtensions.swift
//  swift_exercise1
//
//  Created by Thierry on 2020-12-26.
//  Copyright © 2020 Thierry. All rights reserved.
//

import UIKit

// https://www.codingexplorer.com/create-uicolor-swift/
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
