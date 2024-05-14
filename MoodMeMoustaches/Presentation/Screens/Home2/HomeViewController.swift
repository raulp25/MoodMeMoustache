//
//  RocketListViewController.swift
//  rs5
//
//  Created by Raul Pena on 22/04/24.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let viewModel = RocketListViewModel(service: RocketListService(client: URLSession.shared))
    
    private let navTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "Wizeline"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.allowsSelection = true
        tv.backgroundColor = .systemBackground
        tv.register(RocketListCell.self, forCellReuseIdentifier: RocketListCell.identifier)
        return tv
    }()
    
    private lazy var refresher: UIRefreshControl = {
       let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refresher
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableview()
        viewModel.delegate = self
        Task{ await viewModel.getAllRockets() }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(navTitleLabel)
        view.addSubview(tableView)
        
        navTitleLabel.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            paddingLeft: 10
        )
        
        tableView.anchor(
            top: navTitleLabel.bottomAnchor,
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor
        )
    }
    
    private func setupTableview() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableView.automaticDimension
        tableView.refreshControl = refresher
        tableView.backgroundColor = .systemBackground
    }
    
    
    @objc private func handleRefresh() {
        Task{ await viewModel.getAllRockets() }
        refresher.endRefreshing()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rockets.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RocketListCell.identifier, for: indexPath) as? RocketListCell else {
            fatalError("RocketListVC table view couldn't dequeue RocketCell")
        }
        
        let rocket = viewModel.rockets[indexPath.row]
        
        cell.configure(with: rocket)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = MockVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: RocketListViewModelDelegate {
    func rocketsDidChange() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
