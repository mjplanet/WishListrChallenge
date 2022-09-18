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
    
}

extension MovieListPresenter: MovieListPresenterInterface {
    
    func viewDidLoad() {
        view?.initialSetup()
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        
        var movies: [Movie] = [.init(title: "Batman", year: "1994", posterPath: nil), .init(title: "Hell", year: "2009", posterPath: nil)]
        
        movies = movies.sorted(by: { $0.title ?? "" > $1.title ?? "" })
        
        view?.updateSnapshot(from: movies)
    }
    
    func sortButtonDidTap() {
        let movies: [Movie] = [.init(title: "Batman", year: "1994", posterPath: nil), .init(title: "Hell", year: "2009", posterPath: nil)]
        
        view?.updateSnapshot(from: movies)
    }
    
}
