//
//  LoginMethod.swift
//  FruityFruits
//
//  Created by Hackeru_Student on 10/3/18.
//  Copyright © 2018 Hackeru_Student. All rights reserved.
//

import UIKit

func saveLoginDetails(typedUser:String, typedPass:String){
    
        //once connection is achieved, the information is saved:
        UserDefaults.standard.set(typedUser,forKey: "email")
        UserDefaults.standard.set(typedPass,forKey: "password")
        UserDefaults.standard.synchronize()
}

