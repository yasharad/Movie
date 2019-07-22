//
//  NibLoadableViewExtension.swift
//  Movie
//
//  Created by Yashar on 6/18/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import Foundation
import UIKit

extension NibLoadableView where Self: UIView {
    
    static var nibName: String {
        return String(describing: self)
    }
    
    static var bundle: Bundle {
        return Bundle(for: Self.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: bundle)
    }
    
    static func loadFromNib(withOptions options: [UINib.OptionsKey: Any]? = nil) -> Self {
        guard let object = nib.instantiate(withOwner: nil, options: options).first else {
            fatalError("Could not load nib with name \"\(nibName)\"")
        }
        
        guard let result = object as? Self else {
            fatalError("Loaded object from nib with name \"\(nibName)\" is not of type \"\(self)\"")
        }
        
        return result
    }
    
}
