//
//  LoginVC.swift
//  FruityFruits
//
//  Created by Hackeru_Student on 10/2/18.
//  Copyright © 2018 Hackeru_Student. All rights reserved.
//

import UIKit

class LoginVC: UIViewController{
 
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    private var activityIndicator:UIActivityIndicatorView!

    var be:BEClass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        be = BEClass()
        be.BEConnection()
        print("test")
        
        //pulling connection data if such data was saved
        let email = UserDefaults.standard.string(forKey: "email")
        let password = UserDefaults.standard.string(forKey: "password")
        print("test")

        if email != nil && password != nil{
            login(typedUser: email!, typedPass: password!)
        }
    }
    @IBAction func btnRegisterTapped(sender: UIButton) {
        let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    @IBAction func btnLoginTapped(_ sender: UIButton){

    

        var typedUser = txtUser.text!
        var typedPass = txtPass.text!
        
        self.login(typedUser: typedUser, typedPass: typedPass)
    }
    
    func login(typedUser:String, typedPass:String){
        
        if typedUser.isEmpty{
            print("The username field is empty")
            
            // create an alert (like AlertDialog in android)
            let alert = UIAlertController(title: "Empty username field", message: "A username is required", preferredStyle: .alert)
            
            // create an action - a button to add to the alert (like positiveButton for alertDialog in android)
            let closeAction = UIAlertAction(title: "Ok", style: .default) { _ in // here we are defining a function to run if the button we added it tapped
                alert.dismiss(animated: true, completion: nil)// close the alert
            }
            
            alert.addAction(closeAction) // add the action (button) we defined above to the alert (liek setPositiveButton for alertDialog in android)
            
            // show the alert
            self.present(alert, animated: true, completion: {
                // completion will run once the alert is finished being presented
                print("alert is now open")
            })
            //stoping the application run to prevent connection to BE in case no username was typed
            return
        }
        
        if typedPass.isEmpty{
            // create an alert (like AlertDialog in android)
            let alert = UIAlertController(title: "Empty password field", message: "A password is required", preferredStyle: .alert)
            
            // create an action - a button to add to the alert (like positiveButton for alertDialog in android)
            let closeAction = UIAlertAction(title: "Ok", style: .default) { _ in // here we are defining a function to run if the button we added it tapped
                alert.dismiss(animated: true, completion: nil)// close the alert
            }
            
            alert.addAction(closeAction) // add the action (button) we defined above to the alert (liek setPositiveButton for alertDialog in android)
            
            // show the alert
            self.present(alert, animated: true, completion: {
                // completion will run once the alert is finished being presented
                print("alert is now open")
            })
            //stoping the application run to prevent connection to BE in case no password was typed
            return
        }
        
        activityIndicator = loader(view: self.view)
        
        //connection to BE and login
        be.backendless.userService.login(typedUser, password:typedPass, response: {registerUser in
            stopLoader(view: self.view, activityIndicator: self.activityIndicator)
            saveLoginDetails(typedUser: typedUser, typedPass: typedPass)
            
            
            //transfer to the next page
            let chosenFruits = self.storyboard?.instantiateViewController(withIdentifier: "ChosenFruitsVC") as! ChosenFruitsVC
            
            let fruitData = UserDefaults.standard.object(forKey: "selectedFruit") as? Data
            if fruitData != nil {
                let decodedFruit = NSKeyedUnarchiver.unarchiveObject(with: fruitData!) as? [Fruit]
                chosenFruits.chosenFruits = decodedFruit ?? []
            }
            else{
                chosenFruits.chosenFruits = []
            }
            
            self.navigationController?.pushViewController(chosenFruits, animated: true)
            print("You are logged in")
        }, error: {fault in
            stopLoader(view: self.view, activityIndicator: self.activityIndicator)
            print("A connection error occured: \(fault)")
            
            // create an alert (like AlertDialog in android)
            let alert = UIAlertController(title: "Connection error", message: "The password or the username or both are incorrect", preferredStyle: .alert)
            
            // create an action - a button to add to the alert (like positiveButton for alertDialog in android)
            let closeAction = UIAlertAction(title: "Ok", style: .default) { _ in // here we are defining a function to run if the button we added it tapped
                alert.dismiss(animated: true, completion: nil)// close the alert
            }
            
            alert.addAction(closeAction) // add the action (button) we defined above to the alert (liek setPositiveButton for alertDialog in android)
            
            // show the alert
            self.present(alert, animated: true, completion: {
                // completion will run once the alert is finished being presented
                print("alert is now open")
            })
            //stoping the application run to prevent connection to BE in case no password was typed
            return
        })
    }
}
