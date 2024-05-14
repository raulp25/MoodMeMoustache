//
//  HomeTabCoordinator.swift
//  pethug
//
//  Created by Raul Pena on 16/09/23.
//

import UIKit

final class HomeTabCoordinator: NSObject, ChildTabCoordinator {
    var childCoordinators: [NavCoordinator] = .init()
    
    var parentCoordinator: InAppCoordinator?
    
    var rootViewController: UINavigationController = .init()
    //VieModel class instance gets shared across this module vc's
//    let viewModel: PetsViewModel =
    
    func start() {
        let vc = HomeViewController()
//        vc.delegate = self
        rootViewController.navigationBar.isHidden = true
        rootViewController.pushViewController(vc, animated: true)
    }
    
//    func startRabbits() {
//        let vc = PetsViewController(viewModel: viewModel)
//        viewModel.navigation = self
//        viewModel.collection = .getPath(for: .rabbits)
//        vc.hidesBottomBarWhenPushed = true
//        rootViewController.pushViewController(vc, animated: true)
//    }
}

//extension HomeTabCoordinator: AnimalsStackNavigatable {
//    func didTapAllPetsBanner() {
//        startAllPets()
//    }
//    func didTapDogsBanner() {
//        startDogs()
//    }
//    
//    func didTapCatsBanner() {
//        startCats()
//    }
//    
//    func didTapBirdsBanner() {
//        startBirds()
//    }
//    
//    func didTapRabbitsBanner() {
//        startRabbits()
//    }
//}
//
//extension HomeTabCoordinator: PetsNavigatable {
//    func tappedFilter() {
//        let vc = FilterPetsContentViewController()
//        vc.coordinator = self
//        rootViewController.pushViewController(vc, animated: true)
//    }
//    
//
//    func tapped(pet: Pet) {
//        let vc = PetContentViewController(snapData: [
//            .init(
//                key: .gallery,
//                values: [.images(pet.imagesUrls.map({ $0 }))]),
//            .init(
//                key: .nameLocation,
//                values: [.nameLocation(.init(name: pet.name, breed: pet.breed, address: pet.address.rawValue))]),
//            .init(
//                key: .info,
//                values: [.info(.init(age: pet.age, gender: pet.gender, size: pet.size, activityLevel: pet.activityLevel, socialLevel: pet.socialLevel, affectionLevel: pet.affectionLevel))]),
//            .init(
//                key: .description,
//                values: [.description(pet.info)]),
//            .init(
//                key: .medical,
//                values: [.medical(.init(internalDeworming: pet.medicalInfo.internalDeworming, externalDeworming: pet.medicalInfo.externalDeworming, microchip: pet.medicalInfo.microchip, sterilized: pet.medicalInfo.sterilized, vaccinated: pet.medicalInfo.sterilized))]),
//            .init(
//                key: .social,
//                values: [.social(.init(maleDogFriendly: pet.socialInfo.maleDogFriendly, femaleDogFriendly: pet.socialInfo.femaleDogFriendly, maleCatFriendly: pet.socialInfo.maleCatFriendly, femaleCatFriendly: pet.socialInfo.femaleCatFriendly))])
//        ])
//        vc.hidesBottomBarWhenPushed = true
//        rootViewController.pushViewController(vc, animated: true)
//    }
//}
//
