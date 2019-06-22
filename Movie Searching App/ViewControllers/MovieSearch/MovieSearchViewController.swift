//
//  MovieSearchViewController.swift
//  Movie Searching App
//
//  Created by Murat Emre Aygün on 20.06.2019.
//  Copyright © 2019 muratemreaygun. All rights reserved.
//

import Foundation
import UIKit

class MovieSearchViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchForSomethingLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    var fetching: Bool = false
    var canFetchMore: Bool {
        return movieSearchViewModel.canFetchMore
    }
    
    let movieSearchViewModel = MovieSearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyling()
        tableView.registerCustomTableViewNibCells(classNames: [SearchedMovieCell.self])
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateVisibilities()
    }
    
    // MARK: Service Call
    
    private func fetchSearchedItems(reset: Bool) {
        fetching = true
        
        if reset {
            movieSearchViewModel.page = 1
        }
        else {
            movieSearchViewModel.page += 1
        }
        
        if reset {
            CustomActivityIndicator.shared.startActivity(to: self.view)
        }
        movieSearchViewModel.getSearchedMovies() {[weak self] (isSuccessful: Bool) in
            CustomActivityIndicator.shared.endActivity()
            guard let strongSelf = self else {return}
            strongSelf.fetching = false
            if isSuccessful {
                strongSelf.tableView.reloadData()
                if let results = strongSelf.movieSearchViewModel.movieSearchResults {
                    if strongSelf.movieSearchViewModel.page == 1 && results.count > 0 {
                        strongSelf.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                    }
                }
            }
            strongSelf.updateVisibilities()
        }
        
    }
    
    // MARK: Styling
    
    private func applyStyling() {
        titleLabel.text = "MOVIE SEARCH SCREEN"
        titleLabel.adjustsFontSizeToFitWidth = true
        searchForSomethingLabel.textColor = UIColor.red
        changeInfoText()
    }
    
    func updateVisibilities() {
        if movieSearchViewModel.searchString != "" && movieSearchViewModel.searchString != nil {
            if let results = movieSearchViewModel.movieSearchResults {
                if results.count > 0 {
                    tableView.isHidden = false
                }
                else {
                    tableView.isHidden = true
                }
            }
            else {
                tableView.isHidden = true
            }
        } else {
            tableView.isHidden = true
        }
        changeInfoText()
    }
    
    func changeInfoText() {
        if movieSearchViewModel.searchString != "" && movieSearchViewModel.searchString != nil {
            searchForSomethingLabel.text = "No Results Found"
        }
        else {
            searchForSomethingLabel.text = "Currently There Is Nothing To Search. Type For The Movie You Want To Search"
        }
    }
    
    // MARK: UITableViewDelegate & UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let results = movieSearchViewModel.movieSearchResults {
            return results.count
        }
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchedMovieCell.reuseIdentifier(), for: indexPath) as! SearchedMovieCell
        cell.update(searchData: movieSearchViewModel.movieSearchResults![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let result = movieSearchViewModel.movieSearchResults?[indexPath.row] {
            movieSearchViewModel.selectedMovie = result
            let movieDetailViewController = UIStoryboard(name: Storyboards.movies.rawValue, bundle: nil).instantiateViewController(withIdentifier: Constants.controllerIdMovieDetail) as! MovieDetailViewController
            movieDetailViewController.movieSearchViewModel = self.movieSearchViewModel
            self.navigationController?.pushViewController(movieDetailViewController, animated: true);
        }
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        movieSearchViewModel.searchString = searchBar.text
        if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height) {
            if canFetchMore && !fetching {
                if movieSearchViewModel.searchString != "" && movieSearchViewModel.searchString != nil {
                    fetchSearchedItems(reset: false)
                }
            }
        }
    }
    
    // MARK: UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if movieSearchViewModel.searchString != searchBar.text {
            movieSearchViewModel.searchString = searchBar.text
            if movieSearchViewModel.searchString != "" && movieSearchViewModel.searchString != nil {
                fetchSearchedItems(reset: true)
            }
            else {
                updateVisibilities()
            }
        }
        else {
            updateVisibilities()
        }
    }
}


