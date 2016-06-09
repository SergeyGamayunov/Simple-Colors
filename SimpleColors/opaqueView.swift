//
//  extension.swift
//  SimpleColors
//
//  Created by Admin on 17.05.16.
//  Copyright © 2016 Serj. All rights reserved.
//

import Foundation
import UIKit

private let tagForOpaqueView = 666


//extension to opaque view
extension UIView {

    func addOpaqueView(alpha: CGFloat, color: UIColor) {
        let opaqueView = UIView(frame: self.frame)
        opaqueView.tag = tagForOpaqueView
        opaqueView.backgroundColor = color
        opaqueView.alpha = alpha
        self.addSubview(opaqueView)
    }
    
    func removeOpaqueView() {
        if let opaqueView = self.viewWithTag(tagForOpaqueView) {
            opaqueView.removeFromSuperview()
        }
    }
    
}


