//
//  UIViewController.swift
//  Baluchon
//
//  Created by Arnaud Dalbin on 12/04/2020.
//  Copyright © 2020 Arnaud Dalbin. All rights reserved.
//

import UIKit

extension UIViewController {
   
    // method to display an alert
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    // method to manage button and activity controller together
    func activityIndicator(activityIndicator: UIActivityIndicatorView, button: UIButton, showActivityIndicator: Bool){
        activityIndicator.isHidden = !showActivityIndicator
        button.isHidden = showActivityIndicator
    }
}
