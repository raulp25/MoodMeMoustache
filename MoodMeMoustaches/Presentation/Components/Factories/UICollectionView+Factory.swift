//  MoodMeMoustaches

import UIKit

extension UICollectionView {
    static func createDefaultCollectionView(frame: CGRect = .zero, layout: UICollectionViewLayout) -> UICollectionView {
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        return collectionView
    }
}

