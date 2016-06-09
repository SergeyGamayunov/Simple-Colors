//
//  randomColor.swift
//  SimpleColors
//
//  Created by Сергей Гамаюнов on 09.06.16.
//  Copyright © 2016 Serj. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class func randomColor() -> UIColor {
        var randomArray: [CGFloat] = [0.0, 0.0, 0.0]
        
        for i in 0...2 {
            randomArray[i] = CGFloat(arc4random_uniform(255))/255.0
        }
        
        print("Random color is red \(Int(randomArray[0])) green \(Int(randomArray[1])) blue \(Int(randomArray[2]))")
        return UIColor(red: randomArray[0], green: randomArray[1], blue: randomArray[2], alpha: 1.0)
    }

}
