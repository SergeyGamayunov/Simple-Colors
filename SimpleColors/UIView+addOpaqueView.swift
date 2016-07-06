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
        
        var frame = CGRect()
        
        if self is UITableView {
            let tableView = self as! UITableView
            let frameY = self.frame.height + tableView.contentOffset.y
            let frameX = self.frame.width
            let size = CGSize(width: frameX, height: frameY)
            let origin = self.frame.origin
            frame = CGRect(origin: origin, size: size)
        } else {
            frame = self.frame
        }
        
        let opaqueView = UIView(frame: frame)
        opaqueView.tag = tagForOpaqueView
        opaqueView.backgroundColor = color
		
        self.addSubview(opaqueView)
		opaqueView.fade(false)
    }
    
    func removeOpaqueView() {
        if let opaqueView = self.viewWithTag(tagForOpaqueView) {
			opaqueView.fade(true)
			opaqueView.removeFromSuperview()
		}
			
	}
	
	func fade(fading: Bool, duration: NSTimeInterval = 1.0) {
		if fading {
			UIView.animateWithDuration(duration) {
				self.alpha = 0.0
			}
		} else {
			self.alpha = 0.0
			UIView.animateWithDuration(duration) {
				self.alpha = 0.8
			}
		}
		
	}
	
	
}