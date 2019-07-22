//
//  ReusableView.swift
//  Movie
//
//  Created by Yashar on 6/18/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import Foundation
protocol ReusableView {
    /// Reuse identifier of this view
    static var reuseIdentifier: String { get }
}
