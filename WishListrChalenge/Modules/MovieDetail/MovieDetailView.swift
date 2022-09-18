//
//  MovieDetailView.swift
//  WishListrChalenge
//
//  Created Mobin Jahantark on 9/18/22.
//  Copyright © 2022 mobinjt.com. All rights reserved.
//

import UIKit

protocol MovieDetailViewInterface: AnyObject {
    func setMovieValues(_ movie: MovieItem)
}

class MovieDetailView: UIViewController {
    
    var presenter: MovieDetailPresenterInterface!
    
    
    // MARK: - Properties
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var movieYearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        addSubviews()
        setupConstraints()
        applyTheme()
    }
    
    
    // MARK: - Setups
    private func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(stackView)
        stackView.addArrangedSubview(movieNameLabel)
        stackView.addArrangedSubview(movieYearLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32)
        ])


    }
    
    
    // MARK: - Theme
    private func applyTheme() {
        view.backgroundColor = .systemGray5
    }
    
    
    // MARK: - Actions
    
    
}



extension MovieDetailView: MovieDetailViewInterface {

    func setMovieValues(_ movie: MovieItem) {
        imageView.setRemoteImage(with: movie.posterPath)
        movieNameLabel.text = movie.title
        movieYearLabel.text = movie.year
    }
}
