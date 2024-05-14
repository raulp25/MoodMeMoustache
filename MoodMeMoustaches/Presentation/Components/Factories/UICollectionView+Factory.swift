//
//  UICollectionView+Factory.swift
//  pethug
//
//  Created by Raul Pena on 19/09/23.
//

import UIKit

extension UICollectionView {
    static func createDefaultCollectionView(frame: CGRect = .zero, layout: UICollectionViewLayout) -> UICollectionView {
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }
}

