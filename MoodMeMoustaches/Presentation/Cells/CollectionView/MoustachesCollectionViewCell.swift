//  MoodMeMoustaches

import UIKit

class MoustachesCollectionViewCell: UICollectionViewCell {
    static let identifier = "MoustachesCollectionViewVecll"
    
    private var backView: UIView = {
        let uv = UIView()
        uv.layer.cornerRadius = 10
        uv.backgroundColor = .white.withAlphaComponent(0.6)
        return uv
    }()
    private var  moustacheImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        moustacheImageView.image = nil
    }
    
    func setupUI() {
        contentView.addSubview(backView)
        contentView.addSubview(moustacheImageView)
        
        backView
            .fillSuperview()
        moustacheImageView
            .fillSuperview()
    }
    
    func configure(with imageName: String) {
        moustacheImageView.image = UIImage(named: imageName)
    }

}

