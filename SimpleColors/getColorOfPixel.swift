//
//  getColorOfPixel.swift
//  SimpleColors
//
//  Created by Сергей Гамаюнов on 09.06.16.
//  Copyright © 2016 Serj. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    subscript (x: Int, y: Int) -> UIColor? {
        
        print("Subscript extension. X is \(x), Y is \(y)")
        print("Subscript extension. Width is \(self.size.width), Height is \(self.size.height)")
        
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
        let color = UIColor(red: r, green: g, blue: b, alpha: a)
        print("UIImage extension. returning color is \(color)")
        return color
    }
}