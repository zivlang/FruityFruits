//
//  Fruit.swift
//  FruityFruits
//
//  Created by Hackeru_Student on 8/29/18.
//  Copyright © 2018 Hackeru_Student. All rights reserved.
//

import Foundation

@objcMembers
class Fruit: NSObject, NSCoding{
    
    static let key_id = "id"
    static let key_name = "name"
    static let key_water = "water"
    static let key_vitaimnC = "vitaminC"
    static let key_energy = "energy"
    static let key_iron = "iron"
    
    var objectId: String?
    var name: String?
    var water: String?
    var vitaminC: String?
    var energy: String?
    var iron: String?
    
    override init(){}
    
    init(objectId: String?, name: String?, water:String?, vitaminC:String?, energy:String?, iron:String?) {
        self.objectId = objectId
        self.name = name
        self.water = water
        self.vitaminC = vitaminC
        self.energy = energy
        self.iron = iron
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // for each class property we decode the contents of the respecitve key
        let objectId = aDecoder.decodeObject(forKey: Fruit.key_id) as? String
        let name = aDecoder.decodeObject(forKey: Fruit.key_name) as? String
        let water = aDecoder.decodeObject(forKey: Fruit.key_water) as? String
        let vitaminC = aDecoder.decodeObject(forKey: Fruit.key_vitaimnC) as? String
        let energy = aDecoder.decodeObject(forKey: Fruit.key_energy) as? String
        let iron = aDecoder.decodeObject(forKey: Fruit.key_iron) as? String
        self.init(objectId: objectId, name: name, water: water, vitaminC: vitaminC, energy: energy, iron: iron) // initialize a new object with the data we decoded
    }
    
    func encode(with aCoder: NSCoder) {
        // for each class property we encode the contents of the property with the repective key
        aCoder.encode(self.objectId, forKey: Fruit.key_id)
        aCoder.encode(self.name, forKey: Fruit.key_name)
        aCoder.encode(self.water, forKey: Fruit.key_water)
        aCoder.encode(self.vitaminC, forKey: Fruit.key_vitaimnC)
        aCoder.encode(self.energy, forKey: Fruit.key_energy)
        aCoder.encode(self.iron, forKey: Fruit.key_iron)
    }
    
    

}
