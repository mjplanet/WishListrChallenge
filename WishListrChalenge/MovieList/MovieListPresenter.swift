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
    func sortButtonDidTap()
}

class MovieListPresenter: NSObject {
    
    weak var view: MovieListViewInterface?
    private var service: MovieApiServiceImplementation
    private var movieItems: [MovieItem]? {
        didSet {
            view?.updateSnapshot(from: movieItems ?? [])
        }
    }
    
    init(service: MovieApiServiceImplementation) {
        self.service = service
    }
    
    private func getMovies() {
        service.movies { result in
            switch result {
            case .success(let movies):
                self.movieItems = movies.movieItems
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension MovieListPresenter: MovieListPresenterInterface {
    
    func viewDidLoad() {
        view?.initialSetup()
        getMovies()
    }
    
    func didSelectItem(at indexPath: IndexPath) {
//        movieItems = movieItems?.sorted(by: { $0.year ?? "" < $1.year ?? ""})
    }
    
    func sortButtonDidTap() {
//        movieItems = movieItems?.sorted(by: { $0.title ?? "" < $1.title ?? ""})
    }
    
}
