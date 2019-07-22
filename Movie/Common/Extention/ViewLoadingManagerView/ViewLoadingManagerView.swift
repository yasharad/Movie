//
//  ViewLoadingManagerView.swift
//  Movie
//
//  Created by Yashar on 6/20/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import Foundation
import UIKit

protocol ViewLoadingManagerView {
    //
    var frame: CGRect { get }
    //
    func showLoading()
    func hideLoading()
    func use(_ view: UIView)
    func dontUse(viewWithTag tag: Int)
}

final class ViewLoadingManager {
    private init() {}
}

// ====================
// MARK: - Loading View
// ====================
extension ViewLoadingManager {
    
    static func presentLoadingView<ViewType: UITableView>(in view: ViewType) {
        view.showLoading()
    }
    
    static func presentLoadingView<ViewType: UICollectionView>(in view: ViewType) {
        view.showLoading()
    }
    
    static func presentLoadingView<ViewType: ViewLoadingManagerView>(in view: ViewType) {
        view.showLoading()
    }
    
    static func hideLoadingView<ViewType: UITableView>(from view: ViewType) {
        view.hideLoading()
    }
    
    static func hideLoadingView<ViewType: UICollectionView>(from view: ViewType) {
        view.hideLoading()
    }
    
    static func hideLoadingView<ViewType: ViewLoadingManagerView>(from view: ViewType) {
        view.hideLoading()
    }
    
}

// ======================
// MARK: - NoContent View
// ======================
extension ViewLoadingManager {
    static func presentNoContentView<ViewType: UITableView>(in view: ViewType, with noContentView: UIView) {
        noContentView.frame = view.frame
        noContentView.tag = 4000
        view.use(noContentView)
    }
    
    static func hideNoContentView<ViewType: UICollectionView>(from view: ViewType) {
        view.dontUse(viewWithTag: 4000)
    }
    
    static func hideNoContentView<ViewType: UITableView>(from view: ViewType) {
        view.dontUse(viewWithTag: 4000)
    }
    
    static func hideNoContentView<ViewType: ViewLoadingManagerView>(from view: ViewType) {
        view.dontUse(viewWithTag: 4000)
    }
    
}
