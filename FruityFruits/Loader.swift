//
//  loaderMethod.swift
//  FruityFruits
//
//  Created by Hackeru_Student on 10/7/18.
//  Copyright © 2018 Hackeru_Student. All rights reserved.
//

import UIKit // must be changed from foundation to uikit in order to deal with view

func loader(view:UIView)->UIActivityIndicatorView{ // -> indicates the return value
// setting up the activity indicator (the actual loader)
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray) // initializing it
    view.addSubview(activityIndicator)// addint the activityIndicator to the uiView
    activityIndicator.center = view.center // giving it a position
    activityIndicator.hidesWhenStopped = true // if the loader isn't animating then hide it
    view.isUserInteractionEnabled = false //disable activities initiated by touching
    activityIndicator.startAnimating()
    
    return activityIndicator
}

func stopLoader(view:UIView, activityIndicator:UIActivityIndicatorView){
    activityIndicator.stopAnimating()
    view.isUserInteractionEnabled = true //enable activities initiated by touching
    activityIndicator.removeFromSuperview()
}

