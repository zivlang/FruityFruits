//
//  ViewController.swift
//  FruityFruits
//
//  Created by Hackeru_Student on 8/19/18.
//  Copyright © 2018 Hackeru_Student. All rights reserved.
//

import UIKit

class FirstList: UIViewController,UITableViewDataSource,UITableViewDelegate{
    // A loader for until the table content is loaded from BE
    private var activityIndicator:UIActivityIndicatorView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruitsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fruitCell", for: indexPath) // the identifier must be writen at the table view cell in the storyboard as well
        cell.textLabel?.text = fruitsList[indexPath.row].name
        return cell
    }
    
    @IBOutlet weak var fruitsTable: UITableView!
    
    var fruitsList = [Fruit]() //[DisplayFruit]()
    
    fileprivate func createList(){
        fruitsList = [Fruit]() //[DisplayFruit]()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //creating a BE instance
        let be = BEClass()
        be.BEConnection()

        let query = DataQueryBuilder()
        query?.addSort(by: "name")
        query?.setPageSize(20)
        //calling the loader
        activityIndicator = loader(view: self.view)
        
        be.backendless.data.of(Fruit.self).find(query, response: { (receivedFruit) in
            self.fruitsList = receivedFruit as! [Fruit]
            self.fruitsTable.reloadData()
            stopLoader(view: self.view, activityIndicator: self.activityIndicator)

        }, error: { (fault) in
            print("error - \(fault)")
            
            stopLoader(view: self.view, activityIndicator: self.activityIndicator)
        })
        
        fruitsTable.dataSource = self
        fruitsTable.delegate = self
    }
    // chosing and removing items with swiping
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let chooseFruit = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Choose") { (action, chooseIndexPath) in
//
//            let cell = tableView.cellForRow(at: chooseIndexPath)
//
//            if self.fruitsList[indexPath.row].isChosen{
//                cell?.backgroundColor = UIColor.white
//                self.fruitsList[chooseIndexPath.row].isChosen = false
//            }
//            else{
//                cell?.backgroundColor = UIColor.darkGray
//                self.fruitsList[chooseIndexPath.row].isChosen = true
//            }
//        }
//
//        if self.fruitsList[indexPath.row].isChosen{
//            chooseFruit.title = "Remove"
//        }
//        else{
//            chooseFruit.title = "Choose"
//        }
//
//        return [chooseFruit]
//    }
    
    fileprivate func createTable(){
        //let fruit = Fruit(name: "name", water: 2, vitamin: "b6", energy: 36, iron: 8)
        let fruit = Fruit()
        fruit.name="the fruit"
        fruit.water = "3"
        fruit.vitaminC = "C"
        fruit.energy = "50"
        fruit.iron = "9"
        
        BEClass().BEConnection()
        Backendless.sharedInstance().data.of(Fruit.self).save(fruit, response: { (newFruit) in
            print("have new fruit with id of \((newFruit as! Fruit).objectId)")
        }) { (fault) in
            print("\(fault)")
        }
    }
    
    @IBAction func btnNextTapped(_ sender: Any) {
        
        guard let selectedIndices = fruitsTable.indexPathsForSelectedRows else{
            print("An error accured")
            return
        }
        
        var selectedFruits = [Fruit]()
        for indexPath in selectedIndices{
            selectedFruits.append(fruitsList[indexPath.row])
        }
        
        //save the selected fruit to the device
        let encodedUser = NSKeyedArchiver.archivedData(withRootObject: selectedFruits)
        UserDefaults.standard.set(encodedUser, forKey: "selectedFruit")
        UserDefaults.standard.synchronize()
//        let backendless = BEClass().backendless
//
//        backendless.data.ofTable("MyFruits").save(selectedFruits, response: {_ in
//        selectedFruits
//        }, error: {(fault) in})
        //navigation to the next screen
        let chosenFruits = self.storyboard?.instantiateViewController(withIdentifier:"ChosenFruitsVC") as! ChosenFruitsVC
        
        chosenFruits.chosenFruits = selectedFruits
        
        self.navigationController?.pushViewController(chosenFruits, animated: true)
    }
}

