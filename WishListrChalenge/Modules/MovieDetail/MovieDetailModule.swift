//
//  MovieDetailModule.swift
//  WishListrChalenge
//
//  Created Mobin Jahantark on 9/18/22.
//  Copyright © 2022 mobinjt.com. All rights reserved.
//

import UIKit

struct MovieDetailModule {
    
    func build() -> UIViewController {
        let view = MovieDetailView()
        let presenter = MovieDetailPresenter()
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
