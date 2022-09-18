//
//  MovieListView.swift
//  WishListrChalenge
//
//  Created Mobin Jahantark on 9/17/22.
//  Copyright © 2022 mobinjt.com. All rights reserved.
//

import UIKit

protocol MovieListViewInterface: AnyObject {
    func updateSnapshot(from movies: [MovieItem])
    func present(_ vc: UIViewController)
}

class MovieListView: UIViewController {
    
    var presenter: MovieListPresenterInterface!
    
    enum Section {
        case main
    }

    // MARK: - Properties
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, MovieItem>?
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configureNavItem()
        configureHierarchy()
        configureDataSource()
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
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
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

        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, movieItem -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell
            cell?.name = movieItem.title
            cell?.year = movieItem.year
            return cell
        })
        
    }
    
    private func createActionSheet() {
        let alertController = UIAlertController(title: "Sort", message: "Select the sort option", preferredStyle: .actionSheet)
        
        let sortByYearAction = UIAlertAction(title: "By Year", style: .default) { [weak self] _ in
            self?.presenter.sortByYearDidTap()
        }
        
        let sortByNameAction = UIAlertAction(title: "By Name", style: .default) { [weak self] _ in
            self?.presenter.sortByNameDidTap()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            alertController.dismiss(animated: true)
        }
        
        alertController.addAction(sortByYearAction)
        alertController.addAction(sortByNameAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
    
    // MARK: - Actions
    @objc private func sortButtonDidTap() {
        createActionSheet()
    }
}

extension MovieListView: MovieListViewInterface {
    
    func updateSnapshot(from movies: [MovieItem]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MovieItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        dataSource?.apply(snapshot)
    }
    
    func present(_ vc: UIViewController) {
        self.present(vc, animated: true)
    }
}

extension MovieListView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.bounds.height + scrollView.contentOffset.y >= scrollView.contentSize.height {
            presenter.didReachEndOfList()
        }
    }
    
}
