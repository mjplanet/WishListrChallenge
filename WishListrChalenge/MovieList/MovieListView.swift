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
    
    enum Section {
        case main
    }

    // MARK: - Properties
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        configureNavItem()
        configureHierarchy()
        configureDataSource()
        
        
        let movies: [Movie] = [.init(title: "Batman", year: "1994", posterPath: nil), .init(title: "Hell", year: "2009", posterPath: nil)]
        
        createSnapshot(from: movies)
    }
    
    
    // MARK: - Setups
    private func configureNavItem() {
        navigationItem.title = "Movie list"
        
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down.circle"),
                                         style: .done,
                                         target: self,
                                         action: #selector(sortButtonDidTap))
        
        navigationItem.rightBarButtonItem = sortButton
        
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.delegate = self
        collectionView.register(SimpleCell.self, forCellWithReuseIdentifier: SimpleCell.identifier)
        view.addSubview(collectionView)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { [weak self] (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            return self.createCollectionSection()
        }
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 16
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: configuration)
    }
    
    private func createCollectionSection() -> NSCollectionLayoutSection {
        
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(80))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 8
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        return section
    }
    
    private func configureDataSource() {

        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, movie -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimpleCell.identifier, for: indexPath) as? SimpleCell
            cell?.name = movie.title
            cell?.year = movie.year
            return cell
        })
        
    }
    
    private func createSnapshot(from movies: [Movie]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        dataSource.apply(snapshot)
    }
    
    // MARK: - Theme
    
    
    
    // MARK: - Actions
    @objc private func sortButtonDidTap() {
        print("Tapped")
    }
    
}



extension MovieListView: MovieListViewInterface {
    
    func initialSetup() {
     
    }
    
}

extension MovieListView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

class SimpleCell: UICollectionViewCell {
    
    // MARK: - Static Variables
    static var identifier: String {
        return String(describing: self)
    }
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var yearLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    var year: String? {
        didSet {
            yearLabel.text = year
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        applyTheme()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func addSubviews() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(yearLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func applyTheme() {
        self.backgroundColor = .systemGray4
        self.layer.cornerRadius = 16
    }
}
