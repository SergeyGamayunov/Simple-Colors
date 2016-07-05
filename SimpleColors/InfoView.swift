//
//  InfoView.swift
//  SimpleColors
//
//  Created by Сергей Гамаюнов on 05.07.16.
//  Copyright © 2016 Serj. All rights reserved.
//

import UIKit

class InfoView: UIView {
	
	var view: UIView!
	var blurView: UIVisualEffectView!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		xibSetup()
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		xibSetup()
	}
	
	func xibSetup() {
		view = loadViewFromNib()
		view.frame = bounds
		
		let effect = UIBlurEffect(style: .ExtraLight)
		blurView = UIVisualEffectView(frame: bounds)
		blurView.effect = effect
		view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
		blurView.addSubview(view)
		addSubview(blurView)
	}
	
	func loadViewFromNib() -> UIView {
		
		let bundle = NSBundle(forClass: self.dynamicType)
		let nib = UINib(nibName: "InfoView", bundle: bundle)
		let viewFromNib = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
		
		return viewFromNib
	}
	
	func setupInfoView() {
		layer.masksToBounds = false
		clipsToBounds = true
		layer.shadowColor = UIColor.blackColor().CGColor
		layer.shadowOffset = CGSizeZero
		layer.shadowRadius = 10
		layer.cornerRadius = 20
		
		
		
		
		
	}

}
