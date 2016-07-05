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
        opaqueView.alpha = alpha
        self.addSubview(opaqueView)
        
        
    }
    
    func removeOpaqueView() {
        if let opaqueView = self.viewWithTag(tagForOpaqueView) {
            opaqueView.removeFromSuperview()
        }
    }
	
	
	class func loadFromNibNamed(nibNamed: String, bundle: NSBundle? = nil) -> UIView? {
		let view = UINib(
			nibName: nibNamed,
			bundle: bundle
			).instantiateWithOwner(nil, options: nil)[0] as? UIView
		print("Info View is \(view)")
		return view
	}
	
}
