//
//  chosenFruitVC.swift
//  FruityFruits
//
//  Created by Hackeru_Student on 8/26/18.
//  Copyright © 2018 Hackeru_Student. All rights reserved.
//

import UIKit

class ChosenFruitsVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var chosenFruits:[Fruit]!
    var activityIndicator:UIActivityIndicatorView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chosenFruits.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chosenFruitCell", for: indexPath)
        cell.textLabel?.text = chosenFruits[indexPath.row].name
        return cell
    }
    
    @IBOutlet weak var chosenFruitsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chosenFruitsTable.dataSource = self
        chosenFruitsTable.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var singleFruit = chosenFruits[indexPath.row]
        
        //nevigation to the next screen
        let fruitDetails = self.storyboard?.instantiateViewController(withIdentifier: "fruitDetailsVC") as! FruitDetailsVC
        //passing information to the next page
        fruitDetails.fruit = singleFruit
        
        self.navigationController?.pushViewController(fruitDetails, animated: true)
    }
}
