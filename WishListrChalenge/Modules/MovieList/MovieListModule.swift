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
        let view = MovieListView()
        let apiClient = ApiClientImplementation()
        let service = MovieApiServiceImplementation(apiClient)
        let presenter = MovieListPresenter(service: service)
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
