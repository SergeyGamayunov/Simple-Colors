//
//  InfoView.swift
//  SimpleColors
//
//  Created by Сергей Гамаюнов on 05.07.16.
//  Copyright © 2016 Serj. All rights reserved.
//

import UIKit

class InfoView: UIView {
	
    @IBOutlet var connectButtons: [UIButton]!
	var view: UIView!
	var blurView: UIVisualEffectView!
	
	let URLFacebookApp = NSURL(string: "fb://profile/sergey.gamayunov.33")!
	let URLFacebookBrowser = NSURL(string: "http://www.facebook.com/sergey.gamayunov.33")!
	let email = NSURL(string: "mailto:sergey.gamayunov.87@gmail.com")!
	
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
		
		let blur = UIBlurEffect(style: .ExtraLight)
		blurView = UIVisualEffectView(effect: blur)
		blurView.frame = bounds
		
		blurView.contentView.addSubview(view)
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
		
		for button in connectButtons {
			button.makeRoundedButton(with: 0.5)
		}
	}
    
    @IBAction func facebookOpenButton(sender: UIButton) {
		if UIApplication.sharedApplication().canOpenURL(URLFacebookApp) {
			UIApplication.sharedApplication().openURL(URLFacebookApp)
		} else {
			UIApplication.sharedApplication().openURL(URLFacebookBrowser)
		}
		
    }
    
    @IBAction func mailOpenButton(sender: UIButton) {
		UIApplication.sharedApplication().openURL(email)
    }

}
