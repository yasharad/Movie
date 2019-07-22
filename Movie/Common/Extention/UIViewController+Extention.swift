//
//  Extention.swift
//  Movie
//
//  Created by Yashar on 6/17/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    /// Presents the error using a UIAlertController of ActionSheet type
    ///
    /// - Parameter error: Error to be presented
    func presentError(_ error: String) {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
       
    }
}

