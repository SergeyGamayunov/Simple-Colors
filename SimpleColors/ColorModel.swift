//
//  File.swift
//  SimpleColors
//
//  Created by Admin on 08.05.16.
//  Copyright © 2016 Serj. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift



class ColorModel {
    var color: UIColor
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var components: [CGFloat] {
        get {
            return [red, green, blue]
        } set {
            red = newValue[0]
            green = newValue[1]
            blue = newValue[2]
        }
    }
    
    init(color: UIColor) {
        self.color = color
        self.getRGBComponentsFromCurrentColor()
    }
    
    func getRGBComponentsFromCurrentColor() {
        for i in 0...2 {
            components[i] = color.components[i]
        }
    }
    
    class func getRandomColor() -> UIColor {
        var randomArray: [CGFloat] = [0.0, 0.0, 0.0]
        
        for i in 0...2 {
            randomArray[i] = CGFloat(arc4random_uniform(255))/255.0
        }
        
        
        print("red \(randomArray[0]) green \(randomArray[1]) blue \(randomArray[2])/n")
        return UIColor(red: randomArray[0], green: randomArray[1], blue: randomArray[2], alpha: 1.0)
    }
    
    func setColorAsCurrent(color: UIColor) {
        self.color = color
        getRGBComponentsFromCurrentColor()
    }
}

enum Colors: Int {
    case Red = 1
    case Green
    case Blue
}


extension UIImage {
    subscript (x: Int, y: Int) -> UIColor? {
        
        if x < 0 || x > Int(size.width) || y < 0 || y > Int(size.height) {
            return nil
        }
        
        let provider = CGImageGetDataProvider(self.CGImage)
        let providerData = CGDataProviderCopyData(provider)
        let data = CFDataGetBytePtr(providerData)
        
        let numberOfComponents = 4
        let pixelData = ((Int(size.width) * y) + x) * numberOfComponents
        
        let r = CGFloat(data[pixelData]) / 255.0
        let g = CGFloat(data[pixelData + 1]) / 255.0
        let b = CGFloat(data[pixelData + 2]) / 255.0
        let a = CGFloat(data[pixelData + 3]) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}
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
