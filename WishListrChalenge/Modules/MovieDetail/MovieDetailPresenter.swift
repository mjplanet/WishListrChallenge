//
//  MovieDetailPresenter.swift
//  WishListrChallenge
//
//  Created Mobin Jahantark on 9/18/22.
//  Copyright © 2022 mobinjt.com. All rights reserved.
//

import Foundation

protocol MovieDetailPresenterInterface {
    func viewDidLoad()
}

class MovieDetailPresenter: NSObject {
    
    weak var view: MovieDetailViewInterface?
    private var movie: MovieItem
    
    init(movie: MovieItem) {
        self.movie = movie
    }
}

extension MovieDetailPresenter: MovieDetailPresenterInterface {
    func viewDidLoad() {
        view?.setMovieValues(movie)
    }
}
