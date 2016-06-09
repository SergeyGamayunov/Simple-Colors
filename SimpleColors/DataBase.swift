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

/*
 Database Class. There are three properties:
 1. realm as itself
 2. array of objects that ALWAYS contains only one object - list of Colors
 3/ number of colors in list. (checking list existing)
 */

class DataBase {
    
    static let realm = try! Realm()
    static var objects: Results<ColorList> = { realm.objects(ColorList) }()
    static var numberOfColors: Int {
        if objects.count > 0 {
            return objects[0].list.count
        } else {
            return 0
        }
    }
    
    class func addColorToDataBase(color: UIColor, name: String) {
        
        let red = color.components[0]
        let green = color.components[1]
        let blue = color.components[2]
        let colorForDB = Color(red: red, green: green, blue: blue, name: name)
        
        //if DB is empty:
        if numberOfColors == 0 {
            deleteAll() //in case there are still empty list (after deleting all colors)
            let newColorList = ColorList()
            newColorList.list.insert(colorForDB, atIndex: 0)
            try! realm.write({
                realm.add(newColorList)
                print("Successfully created new list!")
            })
        } else {
            try! realm.write({
                objects[0].list.insert(colorForDB, atIndex: 0)
            })
        }
    }
    
    class func getColorAtIndex(index: Int) -> (color: UIColor, name: String) {
        
        let red = objects[0].list[index].red
        let green = objects[0].list[index].green
        let blue = objects[0].list[index].blue
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        
        let name = objects[0].list[index].name
        
        return (color, name)
    }
    
    class func removeColorAtIndex(index: Int) {
        try! realm.write({
            objects[0].list.removeAtIndex(index)
        })
    }
    
    class func swapColorsAtIndex(index1: Int, index2: Int) {
        try! realm.write({ 
            objects[0].list.swap(index1, index2)
        })
        
    }

    class func deleteAll() {
        try! realm.write({ 
            realm.deleteAll()
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

class ColorList: Object {
    var list = List<Color>()
}
    
  



