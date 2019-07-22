//
//  ActivityIndicator.swift
//  Movie
//
//  Created by Yashar on 6/20/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import Foundation
import UIKit

extension ViewLoadingManagerView where Self: UIView {
    func showLoading() {
        layoutIfNeeded()
        let activityIndicator = UIActivityIndicatorView()
        createLoadingView(with: activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            if let loadingView = self.viewWithTag(100) {
                loadingView.removeFromSuperview()
            }
            
        }
    }
    
    private func createLoadingView(with activityIndicator: UIActivityIndicatorView) {
        layoutIfNeeded()
        
        let blurEffect = UIBlurEffect(style: .extraLight)
        let loadingView = UIVisualEffectView(effect: blurEffect)
        loadingView.frame = bounds
        
        loadingView.tag = 100
        loadingView.layer.cornerRadius = layer.cornerRadius
        loadingView.clipsToBounds = true
        
        customizeActivityIndicator(with: activityIndicator,
                                   on: loadingView)
        
        self.addSubview(loadingView)
    }
    
    fileprivate func customizeActivityIndicator(with activityIndicator: UIActivityIndicatorView,
                                                on loadingView: UIVisualEffectView) {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .gray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingView.contentView.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: loadingView.contentView.centerXAnchor, constant: 0.0).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: loadingView.contentView.centerYAnchor, constant: 0.0).isActive = true
    }
    
    var frame: CGRect {
        layoutIfNeeded()
        return bounds
    }
    
    func use(_ view: UIView) {
        addSubview(view)
    }
    
    func dontUse(viewWithTag tag: Int) {
        guard let view = viewWithTag(tag) else { return }
        view.removeFromSuperview()
    }
    
}

extension UIView: ViewLoadingManagerView {}
