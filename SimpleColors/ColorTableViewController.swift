//
//  ColorTableViewController.swift
//  SimpleColors
//
//  Created by Admin on 13.05.16.
//  Copyright © 2016 Serj. All rights reserved.
//

import UIKit

class ColorTableViewController: DragNDropViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = (view.frame.size.height - (navigationController?.navigationBar.frame.size.height)!)/3
        print("height of cell is \(self.tableView.rowHeight)")
        self.tableView.allowsMultipleSelection = false
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationItem.backBarButtonItem?.style = .Done
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    @IBAction func infoButton(sender: UIButton) {
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataBase.numberOfColors
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ColorCell", forIndexPath: indexPath) as! ColorCell
        cell.backgroundColor = DataBase.getColorAtIndex(indexPath.row).color
        cell.name.text = DataBase.getColorAtIndex(indexPath.row).name
        //cell.textLabel!.font = UIFont(name: "American Typewriter", size: 21)

        return cell
    }
 

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            DataBase.removeColorAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let showColor = UITableViewRowAction(style: .Normal, title: "Full Screen"){_,_ in
            let showView = UIView(frame: UIScreen.mainScreen().bounds)
            showView.backgroundColor = tableView.cellForRowAtIndexPath(indexPath)?.backgroundColor
            tableView.addSubview(showView)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(ColorTableViewController.dismissShowView))
            tableView.addGestureRecognizer(tap)
            //DataBase.objects[0].list[indexPath.row].
        }
        let delete = UITableViewRowAction(style: .Default, title: "Delete") { (_,_) in
            DataBase.removeColorAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        let components = UITableViewRowAction(style: .Default, title: "RGB") { (_, _) in}
        components.backgroundColor = UIColor.whiteColor()
        return [delete, showColor]
    }
    
    func dismissShowView() {
        tableView.subviews.last?.removeFromSuperview()
    }
    
    override func changeItemsAtIndexes(first: Int, second: Int) {
        DataBase.swapColorsAtIndex(first, index2: second)
    }
  
   
}
