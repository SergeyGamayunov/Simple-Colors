//
//  ColorTableViewController.swift
//  SimpleColors
//
//  Created by Admin on 13.05.16.
//  Copyright © 2016 Serj. All rights reserved.
//

import UIKit

class ColorTableViewController: DragNDropViewController {
    
    var userRowHeight: CGFloat = 0
    var selectedCell: Int = 0
    var showView: UIView!
    var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userRowHeight = (view.frame.size.height - (navigationController?.navigationBar.frame.size.height)!)/3
        self.tableView.rowHeight = userRowHeight
        print("height of cell is \(self.tableView.rowHeight)")
        self.tableView.allowsMultipleSelection = false
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataBase.numberOfColors
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
        //get reusable cell
        let cell = tableView.dequeueReusableCellWithIdentifier("ColorCell", forIndexPath: indexPath) as! ColorCell
		
        //fetch data from DB
        let color = DataBase.getColorAtIndex(indexPath.row).color
		
		//set data
        cell.backgroundColor = color
        cell.colorNameButton.setTitle(DataBase.getColorAtIndex(indexPath.row).name, forState: .Normal)
        cell.HEXLabel.text = color.hexComponents[0] +
							 color.hexComponents[1] +
							 color.hexComponents[2]
        
        cell.redLabel.text   = "\(color.intComponents[0])"
        cell.greenLabel.text = "\(color.intComponents[1])"
        cell.blueLabel.text  = "\(color.intComponents[2])"
        
        for label in cell.cellLabels {
            label.textColor = color.contrastColor()
        }
		
		//setup cell
		cell.colorNameButton.titleLabel?.textAlignment = .Left
		cell.colorNameButton.setTitleColor(color.contrastColor(), forState: .Normal)
		
        return cell
    }

	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		//created dictionary with info we want to passed back to root view
		let color = DataBase.getColorAtIndex(indexPath.row).color
		
		//posted notiications
		let userInfo = ["color": color]
		NSNotificationCenter.defaultCenter().postNotificationName("SecVCPopped", object: self, userInfo: userInfo)
		
		navigationController?.setNavigationBarHidden(true, animated: true)
		navigationController?.popToRootViewControllerAnimated(true)
		
	}
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
  
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let showColor = UITableViewRowAction(style: .Normal, title: "Full Screen") { _,_ in
            self.presentShowView(indexPath)
            tableView.setEditing(false, animated: true)
        }
        
        let delete = UITableViewRowAction(style: .Destructive, title: "Delete") { _,_ in
            DataBase.removeColorAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        
        return [delete, showColor]
    }
	
    func presentShowView(indexPath: NSIndexPath) {
        
        let color = tableView.cellForRowAtIndexPath(indexPath)?.backgroundColor!
		
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.prefersStatusBarHidden()
        
        let screenCenter = CGPoint(x: UIScreen.mainScreen().bounds.width/2, y: UIScreen.mainScreen().bounds.height/2 + tableView.contentOffset.y)
        
        let sizeForShowView = CGSize(width: UIScreen.mainScreen().bounds.width*0.85, height: UIScreen.mainScreen().bounds.height*0.85)
        let frameForShowView = CGRect(origin: CGPoint(x: 10, y: 10), size: sizeForShowView)
        showView = UIView(frame: frameForShowView)
        showView.center = screenCenter
        showView.backgroundColor = color
        showView.layer.cornerRadius = showView.bounds.width * 0.1
        showView.layer.shadowRadius = 10.0
        showView.layer.shadowOffset = CGSize(width: 10, height: 10)
    
        showView.layer.shadowColor = color?.contrastColor().CGColor
        
        let frameForInfoLabel = CGRect(x: 10, y: 10, width: 300, height: 100)
        infoLabel = UILabel(frame: frameForInfoLabel)
        infoLabel.text = "Swipe to dismiss..."
        infoLabel.textColor = color!.contrastColor()
        infoLabel.textAlignment = .Center
        infoLabel.center = screenCenter
        
        
        tableView.addOpaqueView(0.7, color: UIColor.blackColor())
        tableView.addSubview(showView)
        tableView.addSubview(infoLabel)
        
        tableView.scrollEnabled = false
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(ColorTableViewController.dismissShowView))
        let tap = UITapGestureRecognizer(target: self, action: #selector(ColorTableViewController.dismissShowView))
        tableView.addGestureRecognizer(tap)
        tableView.addGestureRecognizer(swipe)
    }
    
    func dismissShowView() {
        UIView.animateWithDuration(0.2) {
            self.infoLabel.removeFromSuperview()
            self.showView.frame.origin.x = self.tableView.frame.size.width + 20
        }
        tableView.removeOpaqueView()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        tableView.scrollEnabled = true
    }
    
    override func changeItemsAtIndexes(first: Int, second: Int) {
        DataBase.swapColorsAtIndex(first, index2: second)
    }
  
    @IBAction func colorNameButton(sender: UIButton) {
        
        let point = sender.center
        let pointInView = sender.convertPoint(point, toView: self.view)
        if let indexPath = tableView.indexPathForRowAtPoint(pointInView) {
            
            let alCont = UIAlertController(title: "Name:", message: "Type the name of a color", preferredStyle: .Alert)
            //OK button
            let alAction = UIAlertAction(title: "OK", style: .Default) { _ in
                let name = alCont.textFields![0].text!
                sender.setTitle(name, forState: .Normal)
                DataBase.changeColorNameAtIndex(indexPath.row, name: name)
            }
            
            //Cancel button
            alAction.enabled = false
            let alCancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            
            //Adding buttons
            alCont.addAction(alAction)
            alCont.addAction(alCancel)
            
            //Adding textfield for naming color
            alCont.addTextFieldWithConfigurationHandler{ textField in
                textField.text = DataBase.getColorAtIndex(indexPath.row).name
            }
            
            //observe for empty textfield, switch off OK button
            NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: alCont.textFields![0], queue: nil) { _ in
                let textField = alCont.textFields![0]
                alAction.enabled = !textField.text!.isEmpty
            }
            
            presentViewController(alCont, animated: true, completion: nil)
        }
    }
}





















