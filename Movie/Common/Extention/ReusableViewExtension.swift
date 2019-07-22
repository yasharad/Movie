//
//  ReusableViewExtension.swift
//  Movie
//
//  Created by Yashar on 6/18/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import Foundation
import UIKit

extension ReusableView where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}
