//
//  roundedButton.swift
//  SimpleColors
//
//  Created by Сергей Гамаюнов on 09.06.16.
//  Copyright © 2016 Serj. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
	func makeRoundedButton(with multiplier: CGFloat) {
        self.layer.cornerRadius = self.frame.size.height * multiplier
        self.clipsToBounds = true
    }
}
