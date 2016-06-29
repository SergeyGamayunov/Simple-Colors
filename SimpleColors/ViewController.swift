//
//  ViewController.swift
//  SimpleColors
//
//  Created by Admin on 06.05.16.
//  Copyright © 2016 Serj. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    var colorModel = ColorModel(color: UIColor.whiteColor())
    
    //MARK: - Programmatically views
    var scrollViewForColor = ImageScrollView()
    var minScaleOfScrollView: CGFloat = 0.0
    var imageViewForColor = UIImageView()
    var viewForSampleColor = UIButton()
    let imagePicker = UIImagePickerController()
    
    //MARK: - Boolean markers
    var isScrollViewAppeared: Bool = false {
        didSet {
            if isScrollViewAppeared == true {
                self.disableAll(true)
            } else {
                self.disableAll(false)
            }
        }
    }
    var isSampleColorViewAppeared: Bool = false
    var isBGColorBright: Bool {
        return (view.backgroundColor?.isBright)!
    }
    
//MARK: - Outlets
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var blueView: UIView!
    
    @IBOutlet var changeValueButtonsArray: [UIButton]!
	@IBOutlet var buttonOutlets: [UIButton]!
	@IBOutlet var labelOutlets: [UILabel]!
	
    @IBOutlet weak var writeButtonOutlet: UIButton!
    @IBOutlet weak var libraryButtonOutlet: UIButton!
    @IBOutlet weak var randomButtonOutlet: UIButton!
    @IBOutlet weak var cameraButtonOutlet: UIButton!
    @IBOutlet weak var photoButtonOutlet: UIButton!
	
    
//MARK: - View Did Load!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		//delegates
        imagePicker.delegate = self
        scrollViewForColor.delegate = self
        
        print("Main object is \(DataBase.objects)")
        print("Number of Colors is \(DataBase.numberOfColors)")
		
		//UI setups
        setupButtons()
        makeAndSetRandomColor(0.0)
		
        //listening for ColorTable VC
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(returnedFromLibraryTableViewWithNotificationUserInfo), name: "SecVCPopped", object: nil)
    }
    
    func returnedFromLibraryTableViewWithNotificationUserInfo(notification: NSNotification) {
		
        let userInfo = notification.userInfo as! [String: UIColor]
        let color = userInfo["color"]!
        
        if isScrollViewAppeared {
            scrollViewForColor.removeFromSuperview()
            view.removeOpaqueView()
        }
        colorModel.setColorAsCurrent(color)
        UIView.animateWithDuration(2) {
            self.changeBackGroundColor()
            self.changeSlidersAndLabels()
			self.invertTextColor()
        }
		
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateMinZoomScaleForSize(scrollViewForColor.bounds.size)
    }

    
//MARK: - helping methods
	
	func setupButtons() {
		for button in buttonOutlets {
			let image = button.imageView?.image?.imageWithRenderingMode(.AlwaysTemplate) //get image from button with ignoting color
			button.setImage(image, forState: .Normal) //set image without color back
		}
		
		redSlider.setThumbImage(UIImage(named: "RedThumb"), forState: .Normal)
		greenSlider.setThumbImage(UIImage(named: "GreenThumb"), forState: .Normal)
		blueSlider.setThumbImage(UIImage(named: "BlueThumb"), forState: .Normal)
		
		writeButtonOutlet.makeRoundedButton()
	}
	
    func disableAll(b: Bool) {
        let all = [
            redView, greenView, blueView, writeButtonOutlet, libraryButtonOutlet, randomButtonOutlet, cameraButtonOutlet, photoButtonOutlet
        ]
        for view in all {
            view.userInteractionEnabled = !b
        }
    }
	
    func makeAndSetRandomColor(withDuration: Double) {
        let randomColor = UIColor.randomColor()
        colorModel.setColorAsCurrent(randomColor)
		
        UIView.animateWithDuration(withDuration) {
            self.changeBackGroundColor()
            self.changeSlidersAndLabels()
            self.invertTextColor()
        }
    }
    
    func invertTextColor() {
        let invertColor = colorModel.color.contrastColor()
        
        for label in labelOutlets {
            label.textColor = invertColor
        }
        for button in changeValueButtonsArray {
            button.setTitleColor(invertColor, forState: .Normal)
        }
        for button in buttonOutlets {
            button.tintColor = invertColor
        }
        writeButtonOutlet.backgroundColor = colorModel.color.reverseColor()
    }
    
    func changeBackGroundColor() {
		view.backgroundColor = colorModel.color
    }
    
    func changeSlidersAndLabels() {
        //getting components from model
        let r = Float(255 * (colorModel.red))
        let g = Float(255 * (colorModel.green))
        let b = Float(255 * (colorModel.blue))
        //changing sliders
        redSlider.setValue(r, animated: true)
        greenSlider.setValue(g, animated: true)
        blueSlider.setValue(b, animated: true)
        //changing labels
        redLabel.text = String(Int(r))
        greenLabel.text = String(Int(g))
        blueLabel.text = String(Int(b))
    }
    
    func getColorFromSliders() -> UIColor {
        let r = CGFloat(redSlider.value / 255)
        let g = CGFloat(greenSlider.value / 255)
        let b = CGFloat(blueSlider.value / 255)
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }

//MARK: - function for sliders and plus/minus buttons
    
    @IBAction func slidersTouched(sender: UISlider) {
        
        let colorFromSlider = getColorFromSliders()
        colorModel.setColorAsCurrent(colorFromSlider)
        changeBackGroundColor()
        changeSlidersAndLabels()
        invertTextColor()
        
    }
    //method for all plus/minus button, and small helping method
    @IBAction func stepForSliderButton(sender: UIButton) {
        guard let color = Colors(rawValue: abs(sender.tag)) else { return }
		let plusStep = sender.tag > 0
        switch color {
        case .Red:   stepForSlider(redSlider, plusStep: plusStep)
        case .Green: stepForSlider(greenSlider, plusStep: plusStep)
        case .Blue:  stepForSlider(blueSlider, plusStep: plusStep)
        }
    }
	
	func stepForSlider(slider: UISlider, plusStep: Bool) {
		if plusStep {
			slider.setValue(slider.value + 1, animated: true)
		} else {
			slider.setValue(slider.value - 1, animated: true)
		}
		slidersTouched(slider)
	}
	
    //MARK: - Buttons Methods
    @IBAction func randomColorButton(sender: UIButton) {
        makeAndSetRandomColor(1.4)
    }
    
    @IBAction func photoButton(sender: UIButton) {
        imagePicker.sourceType = .PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraButton(sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .Camera
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
 
    @IBAction func addToDataBaseButton(sender: UIButton) {
        if !isSampleColorViewAppeared { //adding from picture
            addToDataBase(colorModel.color)
        } else {
            addToDataBase(viewForSampleColor.backgroundColor!) //adding current color
            viewForSampleColor.removeFromSuperview()
        }
    }
    
    func addToDataBase(color: UIColor) {
		var name = ""
        let alertController = UIAlertController(title: "Name:", message: "Type the name of a color", preferredStyle: .Alert)
		
        //OK button
        let alAction = UIAlertAction(title: "OK", style: .Default) { (_) in
            name = alertController.textFields![0].text!
            DataBase.addColorToDataBase(color, name: name) //adding color to DB
            self.performSegueWithIdentifier("ColorTableSegue", sender: nil) // and go to the library
        }
        
        //Cancel button
        alAction.enabled = false
        let alCancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        //Adding buttons
        alertController.addAction(alAction)
        alertController.addAction(alCancel)
        
        //Adding textfield for name
        alertController.addTextFieldWithConfigurationHandler(nil)
        
        //observe for empty textfield, switch off OK button
		let textField = alertController.textFields![0]
        NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: textField, queue: nil) { _ in
			let isTextFieldEmpty = textField.text!.isEmpty
            alAction.enabled = !isTextFieldEmpty
        }
        
        presentViewController(alertController, animated: true, completion: nil)
    }
}

//MARK: - UIImagePickerControllerDelegate Protocol Functions
extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        
        //get image from library
        let imageForColorUnrotated = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageForColor = imageForColorUnrotated.fixOrientation()
        print("size of image is \(imageForColor.size)")
        
        //make rect for view
        let imageHeight = imageForColor.size.height
        let imageWidth = imageForColor.size.width
        let ratio = imageHeight/imageWidth
        
        var widthForScrollView: CGFloat = 0.0
        var heightForScrollView: CGFloat = 0.0
        var frameForScrollView = CGRectZero
        
        if ratio > 1.2 {
            widthForScrollView = self.view.frame.size.width - 80
        } else {
            widthForScrollView = self.view.frame.size.width - 30
        }
		
        heightForScrollView = widthForScrollView * ratio
        frameForScrollView = CGRect(x: 0.0, y: 0.0, width: widthForScrollView, height: heightForScrollView)
        
        //dismiss library
        dismissViewControllerAnimated(true, completion: nil)
        
        imageViewForColor = UIImageView(image: imageForColor)
        imageViewForColor.layer.masksToBounds = true;
        imageViewForColor.layer.contentsScale = UIScreen.mainScreen().scale;
        imageViewForColor.layer.masksToBounds = false;
        imageViewForColor.clipsToBounds = true;
        
        scrollViewForColor.frame = frameForScrollView
        scrollViewForColor.center = view.center
        scrollViewForColor.bounces = false
        scrollViewForColor.subviews.last?.removeFromSuperview()
        scrollViewForColor.addSubview(imageViewForColor)
        scrollViewForColor.contentSize = imageViewForColor.bounds.size
        updateMinZoomScaleForSize(scrollViewForColor.bounds.size)
        scrollViewForColor.zoomScale = minScaleOfScrollView
        view.addOpaqueView(0.7, color: UIColor.blackColor())
        view.addSubview(scrollViewForColor)
        
        isScrollViewAppeared = true
        
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.showSampleColor(_:)))
        scrollViewForColor.addGestureRecognizer(longpress)
    }
    
    func showSampleColor(longpress: UILongPressGestureRecognizer) {
        let touch = longpress.locationInView(scrollViewForColor)
        print("Place where we touched image is \(touch)")
        let x = Int(touch.x)
        let y = Int(touch.y)
        let colorOfTouch = imageViewForColor.image![x, y]
		
        viewForSampleColor.frame = CGRect(x: x, y: y, width: 90, height: 90)
        viewForSampleColor.layer.borderWidth = 4
        viewForSampleColor.layer.borderColor = UIColor.blackColor().CGColor
        viewForSampleColor.layer.cornerRadius = viewForSampleColor.frame.size.height / 2
        viewForSampleColor.backgroundColor = colorOfTouch!
        viewForSampleColor.center = view.center
        view.addSubview(viewForSampleColor)
        isSampleColorViewAppeared = true
        scrollViewForColor.userInteractionEnabled = false
        viewForSampleColor.addTarget(self, action: #selector(ViewController.addToDataBaseButton(_:)), forControlEvents: .TouchUpInside)
    }
}


//MARK: - Touch method overridden
extension ViewController {
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if !isScrollViewAppeared {
            return
        }

        //got point of touch and dismiss ScrollView
        if let touchPlace = touches.first?.locationInView(view) {
            
            let isInside = CGRectContainsPoint(scrollViewForColor.frame, touchPlace)
            print(" Place of touch is \(touchPlace) and is Inside \(isInside)")
            if !isInside {
                scrollViewForColor.removeFromSuperview()
                view.removeOpaqueView()
                isScrollViewAppeared = false
            }
            //dismiss sampleView when touched outside its bounds
            let isInsideSampleView = CGRectContainsPoint(viewForSampleColor.frame, touchPlace)
            if !isInsideSampleView {
                viewForSampleColor.removeFromSuperview()
                isSampleColorViewAppeared = false
                scrollViewForColor.userInteractionEnabled = true
            }
        }
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            makeAndSetRandomColor(1.4)
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageViewForColor
    }
    
    private func updateMinZoomScaleForSize(size: CGSize) {
        let widthScale = size.width / imageViewForColor.bounds.width
        let heightScale = size.height / imageViewForColor.bounds.height
        minScaleOfScrollView = min(widthScale, heightScale)
        
        scrollViewForColor.minimumZoomScale = minScaleOfScrollView
        scrollViewForColor.maximumZoomScale = 30.0
    }
}
