//
//  extension.swift
//  SimpleColors
//
//  Created by Admin on 17.05.16.
//  Copyright © 2016 Serj. All rights reserved.
//

import Foundation
import UIKit

//extension to opaque view
extension UIView {

    func addOpaqueView(alpha: CGFloat, color: UIColor) {
        let opaqueView = UIView(frame: self.frame)
        opaqueView.tag = 666
        opaqueView.backgroundColor = color
        opaqueView.alpha = alpha
        self.addSubview(opaqueView)
    }
    
    func removeOpaqueView() {
        if let opaqueView = self.viewWithTag(666) {
            opaqueView.removeFromSuperview()
        }
    }
    
}

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

