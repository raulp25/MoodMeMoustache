//
//  ViewModel.swift
//  rs5
//
//  Created by Raul Pena on 22/04/24.
//

import UIKit

protocol RocketListViewModelDelegate: AnyObject {
    func rocketsDidChange()
}

final class RocketListViewModel {
    
    private(set) var rockets = [Rocket]() {
        didSet {
            filterRockets = rockets
        }
    }
    
    private(set) var filterRockets = [Rocket]() {
        didSet {
            delegate?.rocketsDidChange()
        }
    }
    
    private let service: RocketListService
    weak var delegate: RocketListViewModelDelegate?
    
    
    init(service: RocketListService) {
        self.service = service
    }
    
    func getAllRockets() async {
        do {
            rockets = try await service.getAllRockets()
            print("rockets called: => \(rockets.count)")
        } catch {
            print("DEBUG: error getAllRockets() => \(error)")
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard
            let searchText = searchController.searchBar.text?.lowercased(),
            !searchText.isEmpty
        else {
            self.filterRockets = self.rockets
            return
        }
        self.filterRockets = self.rockets.filter { $0.name?.lowercased().contains(searchText) ?? false }
    }
}
