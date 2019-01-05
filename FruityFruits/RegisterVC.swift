//
//  RegisterVC.swift
//  FruityFruits
//
//  Created by Hackeru_Student on 10/3/18.
//  Copyright © 2018 Hackeru_Student. All rights reserved.
//

import UIKit

class RegisterVC:UIViewController{
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtConfirm: UITextField!
    
    var be:BEClass!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        be = BEClass()
        be.BEConnection()
        }
    
    @IBAction func cancel(_ sender: UIButton) {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    @IBAction func btnRegisterTapped(_ sender: UIButton) {

        let user = BackendlessUser()

        user.email = txtUser.text! as NSString
        user.password = txtPass.text! as NSString
        
        be.backendless.userService.register(user
            , response: { (newUser) in
                
                saveLoginDetails(typedUser: self.txtUser.text!, typedPass: self.txtPass.text!)
                let firstList = self.storyboard?.instantiateViewController(withIdentifier: "FirstList") as! FirstList
                self.navigationController?.pushViewController(firstList, animated: true)
                print("Registration has completed")
        }) { (fault) in
            print("An error occured \(fault)")
        }
    }
}
