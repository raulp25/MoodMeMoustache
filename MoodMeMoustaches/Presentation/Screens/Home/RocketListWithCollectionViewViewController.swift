//
//  RocketListWithCollectionViewViewController.swift
//  rs5
//
//  Created by Raul Pena on 22/04/24.
//

import UIKit

final class RocketListWithCollectionViewViewController: UIViewController {
    private let viewModel = RocketListViewModel(service: RocketListService(client: URLSession.shared))
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let navTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "𝕎izeline🇲🇽"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .systemBackground
        cv.allowsSelection = true
        cv.register(RocketListCollectionCell.self, forCellWithReuseIdentifier: RocketListCollectionCell.identifier)
        return cv
    }()
    
    private lazy var refresher: UIRefreshControl = {
       let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refresher
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupUI()
        setupCollectionView()
        viewModel.delegate = self
        Task{ await viewModel.getAllRockets() }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(navTitleLabel)
        view.addSubview(collectionView)
        navTitleLabel.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            paddingLeft: 10
        )
        
        collectionView.anchor(
            top: navTitleLabel.bottomAnchor,
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor
        )

    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.refreshControl = refresher
    }
    
    private func setupSearchController() {
        self.navigationItem.title = "𝕎izeline"
        
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Cryptos"
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    @objc private func handleRefresh() {
        Task{ await viewModel.getAllRockets() }
        refresher.endRefreshing()
    }
}

extension RocketListWithCollectionViewViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchController.isActive ? viewModel.filterRockets.count : viewModel.rockets.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketListCollectionCell.identifier, for: indexPath) as? RocketListCollectionCell else {
            fatalError("RocketListCollectionViewVC's collectionview failed to dequeue cell RocketListCollectionCell")
        }
        
        let rocket = searchController.isActive ? viewModel.filterRockets[indexPath.row] : viewModel.rockets[indexPath.row]
        
        cell.configure(with: rocket)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let vc = MockVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension RocketListWithCollectionViewViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width / 4) - 4, height: (view.frame.size.width/4) - 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
}

extension RocketListWithCollectionViewViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.updateSearchResults(for: searchController)
    }
}


extension RocketListWithCollectionViewViewController: RocketListViewModelDelegate {
    func rocketsDidChange() {
        DispatchQueue.main.async{ [weak self] in
            self?.collectionView.reloadData()
        }
    }
}
