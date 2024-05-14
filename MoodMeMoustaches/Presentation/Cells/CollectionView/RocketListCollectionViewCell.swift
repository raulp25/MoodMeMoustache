//
//  RocketListCollectionViewCell.swift
//  rs5
//
//  Created by Raul Pena on 22/04/24.
//

import UIKit

class RocketListCollectionCell: UICollectionViewCell {
    static let identifier = "RocketListCollectionCell"
    
    private let rocketImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .lightGray
//        iv.layer.cornerRadius = 80/2
        iv.clipsToBounds = true
        return iv
    }()
    
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    private let rocketNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Rocket Name"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let rocketDescriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "Rocket description"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .label
        label.numberOfLines = 6
        return label
    }()
    
    private let paddingTop: CGFloat = 0 
    private let paddingBottom: CGFloat = 15
    private let paddingLeft: CGFloat = 15
    private let paddingRight: CGFloat = 20
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rocketImageView.sd_cancelCurrentImageLoad()
        rocketImageView.image = nil
        rocketNameLabel.text = nil
        rocketDescriptionLabel.text = nil
        activityIndicator.stopAnimating()
    }
    
    deinit {
        rocketImageView.sd_cancelCurrentImageLoad()
    }
    
    func setupUI() {
        contentView.addSubview(rocketImageView)
        rocketImageView.addSubview(activityIndicator)
//        contentView.addSubview(rocketNameLabel)
//        contentView.addSubview(rocketDescriptionLabel)
        rocketImageView.fillSuperview()
//        rocketImageView.anchor(
//            top: contentView.topAnchor,
//            left: contentView.leftAnchor,
//            paddingTop: paddingTop,
//            paddingLeft: 10
//        )
//        rocketImageView.setDimensions(height: 80, width: 80)
//        
//        activityIndicator.center(inView: rocketImageView)
//        
//        rocketNameLabel.anchor(
//            top: contentView.topAnchor,
//            left: rocketImageView.rightAnchor,
//            right: contentView.rightAnchor,
//            paddingTop: paddingTop,
//            paddingLeft: paddingLeft,
//            paddingRight: paddingRight
//        )
//        
//        rocketDescriptionLabel.anchor(
//            top: rocketNameLabel.bottomAnchor,
//            left: rocketImageView.rightAnchor,
//            bottom: contentView.bottomAnchor,
//            right: contentView.rightAnchor,
//            paddingTop: 5,
//            paddingLeft: paddingLeft,
//            paddingBottom: paddingBottom,
//            paddingRight: paddingRight
//        )
    }
    
    func configure(with rocket: Rocket) {
        load(imageUrl: rocket.flickrImages?[0])
        rocketNameLabel.text = rocket.name ?? "Rocket Name"
        rocketDescriptionLabel.text = rocket.description ?? "Rocket Description"
    }
    
    private func load(imageUrl: String?) {
        guard let imageUrl = imageUrl else {
            rocketImageView.image = UIImage(named: "triangle")
            return
        }
        
        activityIndicator.startAnimating()
        rocketImageView.sd_setImage(with: URL(string: imageUrl)!) { [weak self]  _, error, _, _ in
            self?.activityIndicator.stopAnimating()
            
            guard error == nil else {
                self?.rocketImageView.image = UIImage(named: "triangle")
                return
            }
        }
    }

}
