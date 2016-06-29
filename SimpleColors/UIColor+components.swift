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
    
    var intComponents: [Int] {
        let r = Int(self.components[0] * 255)
        let g = Int(self.components[1] * 255)
        let b = Int(self.components[2] * 255)
        
        return [r, g, b]
    }
    
    var hexComponents: [String] {
        let r = String(format: "%02X", self.intComponents[0])
        let g = String(format: "%02X", self.intComponents[1])
        let b = String(format: "%02X", self.intComponents[2])
        return [r, g, b]
        
    }
    
    var isBright: Bool {
        let sum = self.components[0] + self.components[1] + self.components[2]
        if sum >= 1.5 {
            return true
        } else {
            return false
        }
    }
    
    func reverseColor() -> UIColor {
        let red   = 1 - self.components[0]
        let green = 1 - self.components[1]
        let blue  = 1 - self.components[2]
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func contrastColor() -> UIColor {
        
        let const: CGFloat = 0.6
        
        if self.isBright {
            
            var red   = max(components[0] - const, 0.0)
            var green = max(components[1] - const, 0.0)
            var blue  = max(components[2] - const, 0.0)
            
            let redContr   = const - components[0] + red
            let greenContr = const - components[1] + green
            let blueContr  = const - components[2] + blue
            let contr = redContr + greenContr + blueContr
            
            let minComp = max(red, green, blue)
            if minComp == red {
                red += contr
            } else if minComp == green {
                green += contr
            } else if minComp == blue {
                blue += contr
            }
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
			
        } else {
            var red = min(components[0] + const, 1.0)
            var green = min(components[1] + const, 1.0)
            var blue = min(components[2] + const, 1.0)
            
            let redContr = const + components[0] - red
            let greenContr = const + components[1] - green
            let blueContr = const + components[2] - blue
            let contr = redContr + greenContr + blueContr
            
            let minComp = min(red, green, blue)
            if minComp == red {
                red += contr
            } else if minComp == green {
                green += contr
            } else if minComp == blue {
                blue += contr
            }
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}