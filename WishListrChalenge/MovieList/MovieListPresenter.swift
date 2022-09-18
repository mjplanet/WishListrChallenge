//
//  MovieListPresenter.swift
//  WishListrChalenge
//
//  Created Mobin Jahantark on 9/17/22.
//  Copyright © 2022 mobinjt.com. All rights reserved.
//

import Foundation

protocol MovieListPresenterInterface {
    func viewDidLoad()
    func didSelectItem(at indexPath: IndexPath)
    func sortByYearDidTap()
    func sortByNameDidTap()
    func didReachEndOfList()
}

class MovieListPresenter: NSObject {
    
    weak var view: MovieListViewInterface?
    private var service: MovieApiServiceImplementation
    private var currentPage = 1
    private var movieItems: [MovieItem] = [] {
        didSet {
            view?.updateSnapshot(from: movieItems)
        }
    }
    
    init(service: MovieApiServiceImplementation) {
        self.service = service
    }
    
    private func fetchMovies() {
        service.movies(page: currentPage) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.currentPage += 1
                self?.movieItems += movies.movieItems ?? []
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension MovieListPresenter: MovieListPresenterInterface {
    
    func viewDidLoad() {
        fetchMovies()
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        
    }
    
    func sortByYearDidTap() {
        movieItems = movieItems.sorted(by: { $0.year ?? "" < $1.year ?? ""})
    }
    
    func sortByNameDidTap() {
        movieItems = movieItems.sorted(by: { $0.title ?? "" < $1.title ?? ""})
    }
    
    func didReachEndOfList() {
        fetchMovies()
    }
    
}
