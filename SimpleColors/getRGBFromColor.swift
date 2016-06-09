//
//  getRGBFromColor.swift
//  SimpleColors
//
//  Created by Сергей Гамаюнов on 09.06.16.
//  Copyright © 2016 Serj. All rights reserved.
//

import Foundation
import UIKit

//get components of color
extension UIColor {
    var components: [CGFloat] {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getRed (&r, green: &g, blue: &b, alpha: &a)
        return [r, g, b, a]
    }
}