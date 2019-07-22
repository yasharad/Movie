//
//  UICollectionViewExtension.swift
//  Movie
//
//  Created by Yashar on 6/19/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    /// Registers collectionViewCell with dynamic nib and identifier
    ///
    /// - Parameter cellType: collectionView cell
    func registerCell<CellType: UICollectionViewCell>(_ cellType: CellType.Type) where CellType: NibLoadableView, CellType: ReusableView {
        register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    /// Dequeues collectionViewCell based on the dynamic identifier
    ///
    /// - Parameter indexPath: cell indexpath
    /// - Returns: UICollectionViewCell
    func dequeueReusableCell<CellType: UICollectionViewCell>(for indexPath: IndexPath) -> CellType where CellType: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: CellType.reuseIdentifier, for: indexPath) as? CellType
            else {
                fatalError("could not dequeue cell with identifier: " + CellType.reuseIdentifier)
        }
        return cell
    }
    
}
