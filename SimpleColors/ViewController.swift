//
//  ViewController.swift
//  SimpleColors
//
//  Created by Admin on 06.05.16.
//  Copyright © 2016 Serj. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIScrollViewDelegate {
    
    var colorModel = ColorModel(color: UIColor.whiteColor())
    var scrollViewForColor = ImageScrollView()
    var imageViewForColor = UIImageView()
    var viewForSampleColor = UIButton()
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
    
    
    @IBOutlet weak var writeButtonOutlet: UIButton!
    @IBOutlet weak var libraryButtonOutlet: UIButton!
    @IBOutlet weak var randomButtonOutlet: UIButton!
    @IBOutlet weak var cameraButtonOutlet: UIButton!
    @IBOutlet weak var photoButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Main object is \(DataBase.objects)")
        print("Number of Colors is \(DataBase.numberOfColors)")
        
        if let redSliderImage = UIImage(named: "RedSliderBig") {
            let smallImage = resizeImage(redSliderImage, newWidth: 46)
            redSlider.setThumbImage(smallImage, forState: .Normal)
        }
        if let greenSliderImage = UIImage(named: "GreenSliderBig") {
            //let smallGreenImage = resizeImage(greenSliderImage, newWidth: 46)
            greenSlider.setThumbImage(greenSliderImage, forState: .Normal)
        }
        
        makeRoundedView()
        makeAndSetRandomColor()
    }

    
//MARK: - helping methods
    func disableAll(b: Bool) {
        let all = [
            redView, greenView, blueView, writeButtonOutlet, libraryButtonOutlet, randomButtonOutlet, cameraButtonOutlet, photoButtonOutlet
        ]
        for view in all {
            view.userInteractionEnabled = !b
        }
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func makeRoundedView() {
        let buttons = [
            writeButtonOutlet,
            libraryButtonOutlet,
            randomButtonOutlet,
            cameraButtonOutlet,
            photoButtonOutlet
        ]
        for button in buttons {
            button.makeRoundedButton()
        }
    }
    
    func makeAndSetRandomColor() {
        let randomColor = ColorModel.getRandomColor()
        colorModel.setColorAsCurrent(randomColor)
        UIView.animateWithDuration(2) {
            self.changeBackGroundColor()
            self.changeSlidersAndLabels()
        }

    }
    
    func changeBackGroundColor() {
        let views = [self.view, redView, greenView, blueView]
        for view in views {
            view.backgroundColor = colorModel.color
        }
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
    }
    
    @IBAction func plusButton(sender: UIButton) {
        guard let color: Colors = Colors(rawValue: sender.tag) else {return}
        switch color {
        case .Red:
            let oldValue = Int(redSlider.value)
            let newValue = oldValue + 1
            redSlider.setValue(Float(newValue), animated: true)
            slidersTouched(redSlider)
            print("red")
        case .Green:
            let oldValue = Int(greenSlider.value)
            let newValue = oldValue + 1
            greenSlider.setValue(Float(newValue), animated: true)
            slidersTouched(greenSlider)
            print("green")
        case .Blue:
            let oldValue = Int(blueSlider.value)
            let newValue = oldValue + 1
            blueSlider.setValue(Float(newValue), animated: true)
            slidersTouched(blueSlider)
            print("blue")
        }
    }
    
    @IBAction func minusButton(sender: UIButton) {
        guard let color: Colors = Colors(rawValue: sender.tag) else {return}
        switch color {
        case .Red:
            let oldValue = Int(redSlider.value)
            let newValue = oldValue - 1
            redSlider.setValue(Float(newValue), animated: true)
            slidersTouched(redSlider)
            print("red")
        case .Green:
            let oldValue = Int(greenSlider.value)
            let newValue = oldValue - 1
            greenSlider.setValue(Float(newValue), animated: true)
            slidersTouched(greenSlider)
            print("green")
        case .Blue:
            let oldValue = Int(blueSlider.value)
            let newValue = oldValue - 1
            blueSlider.setValue(Float(newValue), animated: true)
            slidersTouched(blueSlider)
            print("blue")
        }
    }
    
    //MARK: - Buttons

    @IBAction func randomColorButton(sender: UIButton) {
        makeAndSetRandomColor()
    }
    
    @IBAction func photoButton(sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .PhotoLibrary
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func cameraButton(sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .Camera
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func addToDataBase(color: UIColor) {
        var name = ""
        let alCont = UIAlertController(title: "Name:", message: "Type the name of a color", preferredStyle: .Alert)
        //OK button
        let alAction = UIAlertAction(title: "OK", style: .Default) { (_) in
            name = alCont.textFields![0].text!
            DataBase.addColorToDataBase(color, name: name) //adding color to DB
            //self.viewForSampleColor.removeFromSuperview()
            self.performSegueWithIdentifier("ColorTableSegue", sender: nil)
        }
        //Cancel button
        alAction.enabled = false
        let alCancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        //Adding buttons
        alCont.addAction(alAction)
        alCont.addAction(alCancel)
        //Adding textfield for name
        alCont.addTextFieldWithConfigurationHandler(nil)
        //observe for empty textfield, switch off OK button
        NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: alCont.textFields![0], queue: nil) { _ in
            let textField = alCont.textFields![0]
            alAction.enabled = !textField.text!.isEmpty
        }
        
        presentViewController(alCont, animated: true, completion: nil)
    }
    
    @IBAction func addToDataBaseButton(sender: UIButton) {
        if !isSampleColorViewAppeared {
            addToDataBase(colorModel.color)
        } else {
            addToDataBase(viewForSampleColor.backgroundColor!)
            viewForSampleColor.removeFromSuperview()
        }
        
    }
    
    //MARK: - UIImagePickerControllerDelegate Protocol Functions
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        //get image from library
        let imageForColor = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //make rect for view
        let imageHeight = imageForColor.size.height
        print("image height \(imageHeight)")
        
        let imageWidth = imageForColor.size.width
        print("image Width \(imageWidth)")
        
        let ratio = imageHeight/imageWidth
        let viewWidth = self.view.frame.size.width
        let viewHeight = viewWidth * ratio
        let frameForScrollView = CGRect(x: 10.0, y: 10.0, width: viewWidth - 20, height: viewHeight - 20)
        print("Frame for ScrollView is \(frameForScrollView)")
        
        //dismiss library
        dismissViewControllerAnimated(true, completion: nil)
        
//        viewForColor.layer.masksToBounds = true;
//        viewForColor.layer.contentsScale = UIScreen.mainScreen().scale;
//        viewForColor.layer.masksToBounds = false;
//        viewForColor.clipsToBounds = true;

        
        scrollViewForColor.frame = frameForScrollView
        scrollViewForColor.center = view.center
        
        imageViewForColor = UIImageView(image: imageForColor)
        
        scrollViewForColor.addSubview(imageViewForColor)
        scrollViewForColor.contentSize = imageViewForColor.bounds.size
        scrollViewForColor.delegate = self
        view.addOpaqueView(0.7, color: UIColor.blackColor())
        view.addSubview(scrollViewForColor)
        isScrollViewAppeared = true
        
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.showSampleColor(_:)))
        scrollViewForColor.addGestureRecognizer(longpress)
        
    }
    
    func showSampleColor(longpress: UILongPressGestureRecognizer) {
        let touch = longpress.locationInView(imageViewForColor)
        let x = Int(touch.x)
        let y = Int(touch.y)
        let colorOfTouch = imageViewForColor.image![x, y]
        
        viewForSampleColor.frame = CGRect(x: x, y: y, width: 70, height: 70)
        viewForSampleColor.layer.borderWidth = 4
        viewForSampleColor.layer.backgroundColor = UIColor.blackColor().CGColor
        viewForSampleColor.layer.cornerRadius = 35
        viewForSampleColor.backgroundColor = colorOfTouch!
        viewForSampleColor.center = view.center
        view.addSubview(viewForSampleColor)
        isSampleColorViewAppeared = true
        scrollViewForColor.userInteractionEnabled = false
        viewForSampleColor.addTarget(self, action: #selector(ViewController.addToDataBaseButton(_:)), forControlEvents: .TouchUpInside)

    }
    
    
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
            
            let isInsideSampleView = CGRectContainsPoint(viewForSampleColor.frame, touchPlace)
            if !isInsideSampleView {
                viewForSampleColor.removeFromSuperview()
                isSampleColorViewAppeared = false
                scrollViewForColor.userInteractionEnabled = true
            }
        }
    }
}

