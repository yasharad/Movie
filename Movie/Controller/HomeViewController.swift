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
    var movieService: MovieServiceProtocol!
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            
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
        setup()
        getMoviesByName(name: "batman")
    }


}
// ===========================
// MARK: - HomeViewController
// ===========================
private extension HomeViewController {
    func getMoviesByName(name: String) {
        movieService.getMoviesByQuery(query: name, page: 1) {[weak self] (movie, error) in
            DispatchQueue.main.async { [weak self] in
                self?.movieModel = movie
                self?.tableView.reloadData()
            }
        }
    }
    func setup() {
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        //tableView.registerCellNib(MovieTableViewCell.self)
    }
}
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieModel?.results?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        let moviewViewModel = MovieViewModel(movie: movieModel!.results![indexPath.row])
        cell.moveViewModel = moviewViewModel
        return cell
    }


}
