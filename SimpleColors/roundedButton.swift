//
//  roundedButton.swift
//  SimpleColors
//
//  Created by Сергей Гамаюнов on 09.06.16.
//  Copyright © 2016 Serj. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func makeRoundedButton() {
        self.layer.cornerRadius = self.frame.size.height * 0.5
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 215/255, alpha: 1.0)
        self.clipsToBounds = true
        self.titleLabel?.textAlignment = .Center
        self.titleLabel?.baselineAdjustment = .AlignCenters
    }
}
