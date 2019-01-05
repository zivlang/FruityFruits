//
//  fruitDetailsVC.swift
//  Pods-FruityFruits
//
//  Created by Hackeru_Student on 9/5/18.
//

import UIKit

class FruitDetailsVC: UIViewController{
    
    var fruit:Fruit!
    
    @IBOutlet weak var fruitName: UILabel!
    @IBOutlet weak var waterContent: UITextView!
    @IBOutlet weak var VitaminC: UITextView!
    @IBOutlet weak var Energy: UITextView!
    @IBOutlet weak var Iron: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDetails()
    }
        
    func getDetails(){
        
        fruitName.text = fruit.name
        waterContent.text = fruit.water
        VitaminC.text = fruit.vitaminC
        Energy.text = fruit.energy
        Iron.text = fruit.iron
    }

}
