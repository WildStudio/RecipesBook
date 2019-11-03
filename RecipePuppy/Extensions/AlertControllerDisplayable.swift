//
//  AlertControllerDisplayable.swift
//  RecipePuppy
//
//  Created by wearemobilefirst on 03/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import UIKit

protocol AlertControllerDisplayable {
    func displayAlert(with title: String, message: String, actions: [UIAlertAction]?)
}

extension AlertControllerDisplayable where Self: UIViewController {
    
    func displayAlert(
        with title: String,
        message: String,
        actions: [UIAlertAction]? = nil
    ) {
        guard presentedViewController == nil
            else { return }
        
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        actions?.forEach { action in
            alertController.addAction(action)
        }
        
        present(alertController, animated: true)
    }
    
}

