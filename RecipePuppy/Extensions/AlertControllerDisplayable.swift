//
//  AlertControllerDisplayable.swift
//  RecipePuppy
//
//  Created by wearemobilefirst on 03/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import UIKit

protocol AlertControllerDisplayable {
    func displayAlert(with configuration: AlertConfiguration)
}

extension AlertControllerDisplayable where Self: UIViewController {
    
    func displayAlert(
        with configuration: AlertConfiguration
    ) {
        
        let alert = UIAlertController(
            title: configuration.title,
            message: configuration.body,
            preferredStyle: .alert
        )
        
        let actions = configuration.actions.map{ action -> UIAlertAction in
            UIAlertAction(title: action.title, style: action.style.asUIAlertActionStyle) { _ in
                action.handler?()
            }
        }
       
        if actions.isEmpty {
            alert.addAction(
                UIAlertAction(title: "OK", style: .default, handler: nil)
            )
        } else {
            actions.forEach { alert.addAction($0) }
        }
        
        
        present(alert, animated: true)
    }
    
}

