//
//  ViewController.swift
//  SimpleColors
//
//  Created by Admin on 06.05.16.
//  Copyright © 2016 Serj. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var colorModel: ColorModel = ColorModel(color: UIColor.whiteColor())
    var viewForColor: UIImageView = UIImageView()
    var isScrollViewAppeared: Bool = false {
        didSet {
            if isScrollViewAppeared == true {
                self.disableAll(true)
            } else {
                self.disableAll(false)
            }
        }
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
    
    
    @IBOutlet weak var writeButtonOutlet: UIButton!
    @IBOutlet weak var libraryButtonOutlet: UIButton!
    @IBOutlet weak var randomButtonOutlet: UIButton!
    @IBOutlet weak var cameraButtonOutlet: UIButton!
    @IBOutlet weak var photoButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let redSliderImage = UIImage(named: "RedSliderBig") {
            let smallImage = resizeImage(redSliderImage, newWidth: 46)
            redSlider.setThumbImage(smallImage, forState: .Normal)
        }
        if let greenSliderImage = UIImage(named: "GreenSliderBig") {
            let smallGreenImage = resizeImage(greenSliderImage, newWidth: 46)
            greenSlider.setThumbImage(smallGreenImage, forState: .Normal)
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

    
//MARK: - function for buttons
    
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
    
    @IBAction func randomColorButton(sender: UIButton) {
        makeAndSetRandomColor()
    }
    
    @IBAction func slidersTouched(sender: UISlider) {
        
        let colorFromSlider = getColorFromSliders()
        colorModel.setColorAsCurrent(colorFromSlider)
        changeBackGroundColor()
        changeSlidersAndLabels()
        
    }
    
    @IBAction func photoButton(sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .PhotoLibrary
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func addToDataBaseButton(sender: UIButton) {
        
        var name = ""
        let alCont = UIAlertController(title: "Name:", message: "Type the name of a color", preferredStyle: .Alert)
        //OK button
        let alAction = UIAlertAction(title: "OK", style: .Default) { (_) in
            name = alCont.textFields![0].text!
            DataBase.addColorToDataBase(self.colorModel.color, name: name) //adding color to DB
            
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
    
    //MARK: - UIImagePickerControllerDelegate Protocol Functions
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        //get image from library
        let imageForColor = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //make rect for view
        let imageHeight = imageForColor.size.height
        let imageWidth = imageForColor.size.width
        let ratio = imageHeight/imageWidth
        let viewWidth = self.view.frame.size.width
        let viewHeight = viewWidth * ratio
        let frameForScrollView = CGRect(x: 10.0, y: 10.0, width: viewWidth - 20, height: viewHeight - 20)
        print("Frame for ScrollView is \(frameForScrollView)")
        
        //dismiss library
        dismissViewControllerAnimated(true, completion: nil)
        
        //view appears with image
        viewForColor = UIImageView(frame: frameForScrollView)
        viewForColor.image = imageForColor
        
        viewForColor.center = view.center
        print("Frame of Scroll View after settings \(viewForColor.frame)")
        viewForColor.layer.cornerRadius = 20;
        viewForColor.layer.masksToBounds = true;
        
        viewForColor.layer.borderColor = UIColor.blackColor().CGColor;
        viewForColor.layer.borderWidth = 6;
        
        viewForColor.layer.contentsScale = UIScreen.mainScreen().scale;
        
        viewForColor.layer.masksToBounds = false;
        viewForColor.clipsToBounds = true;
        
        view.addOpaqueView(0.7, color: UIColor.blackColor())
        view.addSubview(viewForColor)
        viewForColor.userInteractionEnabled = true
        view.bringSubviewToFront(viewForColor)
        isScrollViewAppeared = true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if !isScrollViewAppeared {
            return
        }
        
        //got point of touch and dismiss ScrollView
        if let touchPlace = touches.first?.locationInView(view) {
            let isInside = CGRectContainsPoint(viewForColor.frame, touchPlace)
            print(" Place of touch is \(touchPlace) and is Inside \(isInside)")
            if !isInside {
                print(viewForColor.frame)
                viewForColor.removeFromSuperview()
                view.removeOpaqueView()
                isScrollViewAppeared = false
            }
        }
    }
}

