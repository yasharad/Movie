//
//  HomeViewController.swift
//  Movie
//
//  Created by Yashar on 7/21/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    // ===========================
    // MARK: - Poperties
    // ===========================
    var movieModel: MovieModel?
    var movieModelArray = [MovieResult]()
    var movieService: MovieServiceProtocol!
    //var dataSource: TableViewDataSource<MovieViewModel>!
    var currentPage: Int = 1
    private var searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            //dataSource = .make(for: movieViewModelArray)
            tableView.dataSource = self
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 400
            tableView.register(HomeTableViewCell.self)
        }
    }
    // ===========================
    // MARK: - Init
    // ===========================
    init(movieService: MovieServiceProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.movieService = movieService
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // ===========================
    // MARK: - Life Cycle
    // ===========================
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchController()
        //getMoviesByName(name: "top gun")
    }
}
// ===========================
// MARK: - HomeViewController
// ===========================
private extension HomeViewController {
    func getMoviesByName(name: String,page: Int) {
        movieService.getMoviesByQuery(query: name, page: currentPage) {[weak self] (movie, error) in
            if error != nil {
                self?.presentError(error!)
            }else{
                DispatchQueue.main.async { [weak self] in
                    self?.movieModel = movie
                    self?.movieModelArray += (movie?.results)!
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    func loadPagination(indexPath: IndexPath) {
        if indexPath.row + 1 == movieModelArray.count &&
            (movieModel!.page! < movieModel!.totalPages!) {
            currentPage += 1
            getMoviesByName(name: searchController.searchBar.text!,page: currentPage)
        }
    }
    
    func setUpSearchController() {
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search movie by name"
        searchController.searchBar.delegate = self
        customSearchField()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func customSearchField() {
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor.white
            textField.font = UIFont.systemFont(ofSize: 14)
            
            let backgroundView = textField.subviews.first
            backgroundView?.backgroundColor = UIColor.white.withAlphaComponent(1)
            backgroundView?.subviews.forEach { $0.removeFromSuperview() }
            backgroundView?.layer.cornerRadius = 10.5
            backgroundView?.layer.masksToBounds = true
        }
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        movieModelArray.removeAll()
        currentPage = 1
        if !searchText.isEmpty{
            getMoviesByName(name: searchText.lowercased(),page: currentPage)
        }
    }
}



// ===========================
// MARK: - UITableViewDataSource
// ===========================
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reuseIdentifier, for: indexPath) as! HomeTableViewCell
        let moviewViewModel = MovieViewModel(movie: movieModelArray[indexPath.row])
        cell.moveViewModel = moviewViewModel
        loadPagination(indexPath: indexPath)
        return cell
    }
}
// =======================
// MARK: - Search Delegate
// =======================
extension HomeViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
// ===========================
// MARK: - SearchBar Delegate
// ===========================
extension HomeViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // called when text changes (including clear)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
            self?.filterContentForSearchText(searchBar.text ?? "")
        }
    }
}
// ===========================
// MARK: - Reusable TableView Data Source (Future work)
// ===========================
//extension TableViewDataSource where Model == MovieViewModel {
//    static func make(for models: [Model],
//                     reuseIdentifier: String = HomeTableViewCell.reuseIdentifier,
//                     delegate: TableViewDataSourceProtocol? = nil) -> TableViewDataSource {
//        return TableViewDataSource(models: models,reuseIdentifier: reuseIdentifier, deleagte: delegate){ (model, cell, indexPath, needLoad, delegate) in
//
//            let cell = (cell as! HomeTableViewCell)
//            cell.moveViewModel = model
//
//        }
//    }
//}
