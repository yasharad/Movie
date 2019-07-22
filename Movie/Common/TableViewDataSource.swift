//
//  TableViewDataSource.swift
//  Movie
//
//  Created by Yashar on 7/15/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import Foundation
import UIKit
 protocol TableViewDataSourceProtocol {
   func loadPagination()
}

class TableViewDataSource<Model>: NSObject, UITableViewDataSource {

    
    typealias CellConfigurator = (Model, UITableViewCell,IndexPath,_ needLoad: Bool,_ delegate: TableViewDataSourceProtocol?) -> Void
    
    var delegate: TableViewDataSourceProtocol?
    var models: [Model]
    
    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator
    
    init(models: [Model], reuseIdentifier: String, deleagte: TableViewDataSourceProtocol? ,cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
        self.delegate = deleagte
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,for: indexPath)
        var needLoad = false
        if models.count == indexPath.row + 1 {
            needLoad = true
            if let delegate = delegate {
                delegate.loadPagination()
            }
        }
        
        cellConfigurator(model, cell, indexPath, needLoad, delegate)
        return cell
    }
    
    
}



