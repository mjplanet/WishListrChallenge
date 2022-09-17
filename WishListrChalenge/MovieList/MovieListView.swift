//
//  MovieListView.swift
//  WishListrChalenge
//
//  Created Mobin Jahantark on 9/17/22.
//  Copyright © 2022 mobinjt.com. All rights reserved.
//

import UIKit

protocol MovieListViewInterface: AnyObject {
    func initialSetup()
}

class MovieListView: UIViewController {
    
    var presenter: MovieListPresenterInterface!
    
    
    // MARK: - Properties
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        
    }
    
    
    // MARK: - Setups
    
    
    
    // MARK: - Theme
    
    
    
    // MARK: - Actions
    
    
}



extension MovieListView: MovieListViewInterface {
    
    func initialSetup() {
        
    }
    
}


