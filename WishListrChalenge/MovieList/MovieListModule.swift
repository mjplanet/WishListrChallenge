//
//  MovieListModule.swift
//  WishListrChalenge
//
//  Created Mobin Jahantark on 9/17/22.
//  Copyright © 2022 mobinjt.com. All rights reserved.
//

import UIKit

struct MovieListModule {
    
    func build() -> UIViewController {
        let view = UIStoryboard.instantiate() as! MovieListView
        let presenter = MovieListPresenter()
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
