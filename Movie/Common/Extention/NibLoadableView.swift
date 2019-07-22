//
//  NibLoadableView.swift
//  Movie
//
//  Created by Yashar on 6/18/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import Foundation
import UIKit

protocol NibLoadableView {
    /// Nib name of this object
    static var nibName: String { get }
    
    /// Bundle containing nib of this object
    static var bundle: Bundle { get }
    
    /// Nib of this object
    static var nib: UINib { get }
    
    /// Loads this object from nib with some options
    ///
    /// - Parameter options: _(optional)_ A dictionary containing the options to use when opening the nib file. For a list of available keys for this dictionary, see NSBundle UIKit Additions.
    /// - Returns: A new instance of this object
    static func loadFromNib(withOptions options: [UINib.OptionsKey: Any]?) -> Self
}
