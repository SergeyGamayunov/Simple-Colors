//
//  ImageScrollView.swift
//  SimpleColors
//
//  Created by Admin on 18.05.16.
//  Copyright © 2016 Serj. All rights reserved.
//

import UIKit

class ImageScrollView: UIScrollView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 6.0
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.cornerRadius = 20.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
}
