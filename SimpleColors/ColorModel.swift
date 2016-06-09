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






