//
//  InfoView.swift
//  SimpleColors
//
//  Created by Сергей Гамаюнов on 05.07.16.
//  Copyright © 2016 Serj. All rights reserved.
//

import UIKit
@IBDesignable
class InfoView: UIView {
	
	@IBOutlet weak var name: UILabel!
	@IBInspectable
	var nametext: String {
		get {
			return name.text!
		} set {
			name.text = newValue
		}
	}
	
    @IBOutlet var connectButtons: [UIButton]!
	var view: UIView!
	var blurView: UIVisualEffectView!
	
	let URLFacebookApp = NSURL(string: "fb://profile/sergey.gamayunov.33")!
	let URLFacebookBrowser = NSURL(string: "http://www.facebook.com/sergey.gamayunov.33")!
	let email = NSURL(string: "mailto:sergey.gamayunov.87@gmail.com")!
	let URLLinkedInBrowser = NSURL(string: "https://www.linkedin.com/in/sergey-gamayunov-3bb99b123")!
	let URLLinkedInApp = NSURL(string: "linkedin://in/sergey-gamayunov-3bb99b123")!
	
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

    @IBAction func linkedInOpenButton(sender: UIButton) {
		if UIApplication.sharedApplication().canOpenURL(URLLinkedInApp) {
			UIApplication.sharedApplication().openURL(URLLinkedInApp)
		} else {
			UIApplication.sharedApplication().openURL(URLLinkedInBrowser)
		}
    }
	
}
