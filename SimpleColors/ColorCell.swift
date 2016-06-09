//
//  ColorCell.swift
//  SimpleColors
//
//  Created by Admin on 26.05.16.
//  Copyright © 2016 Serj. All rights reserved.
//

import UIKit

class ColorCell: UITableViewCell {
    
    let color = UIColor()
    
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        name.layer.borderWidth = 1.0
        name.layer.borderColor = UIColor.blackColor().CGColor
        name.layer.cornerRadius = 10.0
        //name.backgroundColor = UIColor.greenColor()
        
        name.bounds.size.height = 120.0
        print("name.bounds.size.height is \(name.bounds.size.height)")
        //name.frame.size.width = self.frame.width / 4
        
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
