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
}

class MovieListPresenter: NSObject {
    
    weak var view: MovieListViewInterface?
    
}

extension MovieListPresenter: MovieListPresenterInterface {
    
    func viewDidLoad() {
        view?.initialSetup()
    }
    
}
