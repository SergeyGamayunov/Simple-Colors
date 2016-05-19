//
//  DataBase.swift
//  SimpleColors
//
//  Created by Admin on 12.05.16.
//  Copyright © 2016 Serj. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class DataBase {
    static let realm = try! Realm()
    static var numberOfColors: Int {
        return realm.objects(Color).count
    }
    static var colors: Results<Color> = { realm.objects(Color) }()
    class func addColorToDataBase(color: UIColor, name: String) {
        
        let red = color.components[0]
        let green = color.components[1]
        let blue = color.components[2]
        
        let colorForDB = Color(red: red, green: green, blue: blue, name: name)
        try! realm.write({
            realm.add(colorForDB)
            print("Success!")
        })
        
    }
    
    class func removeColorAtIndex(index: Int){
        try! realm.write({
            realm.delete(colors[index])
        })
    }
    
   
    
}

class Color: Object {
    
    dynamic var red: CGFloat = 0
    dynamic var green: CGFloat = 0
    dynamic var blue: CGFloat = 0
    dynamic var name: String = ""
    
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat, name: String) {
        self.init()
        self.red = red
        self.green = green
        self.blue = blue
        self.name = name
    }
    
  
}


