//
//  ColorCell.swift
//  SimpleColors
//
//  Created by Admin on 26.05.16.
//  Copyright © 2016 Serj. All rights reserved.
//

import UIKit

class ColorCell: UITableViewCell {
    
    @IBOutlet var cellLabels: [UILabel]!
    
    @IBOutlet weak var ColorNameButton: UIButton!
    @IBOutlet weak var HEXLabel: UILabel!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
