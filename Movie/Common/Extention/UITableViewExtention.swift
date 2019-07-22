//
//  UITableViewExtention.swift
//  Movie
//
//  Created by Yashar on 6/18/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    /// Registers tableViewCell with dynamic nib and identifier
    ///
    /// - Parameter cellType: tableView cell
    func register<CellType: UITableViewCell>(_ cellType: CellType.Type) where CellType: NibLoadableView, CellType: ReusableView {
        register(cellType.nib, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    /// Dequeues UITableViewCell based on the dynamic identifier
    ///
    /// - Parameter indexPath: cell indexpath
    /// - Returns: UITableViewCell
    func dequeueReusableCell<CellType: UITableViewCell>(for indexPath: IndexPath) -> CellType where CellType: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: CellType.reuseIdentifier,
                                             for: indexPath) as? CellType else {
                                                fatalError("could not dequeue cell with identifier: " + CellType.reuseIdentifier)
        }
        return cell
    }
    
}
