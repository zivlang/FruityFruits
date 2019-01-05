//
//  BackEndless.swift
//  FruityFruits
//
//  Created by Hackeru_Student on 8/29/18.
//  Copyright © 2018 Hackeru_Student. All rights reserved.
//

import Foundation

class BEClass {
    
    let APPLICATION_ID = "18911EE9-AFF8-5DD9-FF50-8D9C7457CA00"
    let API_KEY = "D50D44DA-4735-B1C1-FF71-9023BD53CD00"
    let SERVER_URL = "https://api.backendless.com"
    
    let backendless = Backendless.sharedInstance()! // getting a backendless instance
    
    func BEConnection(){
        // connecting to the BE DB
        backendless.hostURL = SERVER_URL
        backendless.initApp(APPLICATION_ID, apiKey:API_KEY)
        
    }
}
