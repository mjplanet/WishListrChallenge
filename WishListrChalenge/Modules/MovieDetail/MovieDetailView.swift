//
//  MovieDetailView.swift
//  WishListrChalenge
//
//  Created Mobin Jahantark on 9/18/22.
//  Copyright © 2022 mobinjt.com. All rights reserved.
//

import UIKit

protocol MovieDetailViewInterface: AnyObject {
    func initialSetup()
}

class MovieDetailView: UIViewController {
    
    var presenter: MovieDetailPresenterInterface!
    
    
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



extension MovieDetailView: MovieDetailViewInterface {
    
    func initialSetup() {
        
    }
    
}


