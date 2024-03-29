//
//  ImageViewExtention.swift
//  Movie
//
//  Created by Yashar on 7/21/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
extension UIImageView {
    func loadImageAsync(url: URL?){
        guard let _ = url else {
            return
        }
        
        self.kf.setImage(with: url)
    }
}
