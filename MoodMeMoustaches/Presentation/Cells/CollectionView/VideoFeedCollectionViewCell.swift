//
//  VideoFeedCollectionViewCell.swift
//  MoodMeMoustaches
//
//  Created by Raul Pena on 14/05/24.
//

import UIKit
import AVKit

class VideoFeedCollectionViewCell: UICollectionViewCell {
    static let identifier = "VideoFeedCollectionViewCell"
    
    private let videoThumbnailImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .lightGray
        iv.clipsToBounds = true
        return iv
    }()
    
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    private let videoDurationLabel: UILabel = {
       let label = UILabel()
        label.text = "0:00"
        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let videoTagLabel: UILabel = {
       let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .label
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
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
        thumbnailOperation?.cancel()
        videoThumbnailImageView.image = nil
        videoDurationLabel.text = nil
        videoTagLabel.text = nil
        activityIndicator.stopAnimating()
    }
    
    deinit {
        thumbnailOperation?.cancel()
    }
    
    func setupUI() {
        contentView.clipsToBounds = true
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 10
        
        contentView.addSubview(videoThumbnailImageView)
        contentView.addSubview(videoDurationLabel)
        contentView.addSubview(videoTagLabel)
        videoThumbnailImageView.addSubview(activityIndicator)
        
        videoThumbnailImageView.anchor(
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            right: contentView.rightAnchor
        )
        
        videoThumbnailImageView
            .setHeight(contentView.frame.width/1.2 - (8 + 5 + 5)) //taglabel font size + padding top + padding bottom
        
        activityIndicator
            .center(inView: videoThumbnailImageView)
        
        videoDurationLabel.anchor(
            bottom: videoThumbnailImageView.bottomAnchor,
            right: videoThumbnailImageView.rightAnchor,
            paddingBottom: 5,
            paddingRight: 5
        )
        
        videoTagLabel.anchor(
            left: contentView.leftAnchor,
            bottom: contentView.bottomAnchor,
            right: contentView.rightAnchor,
            paddingLeft: 7,
            paddingBottom: 7
        )
    }
    
    func configure(with video: Video) {
        loadVideoThumbnai(with: video.videoUrl)
        videoDurationLabel.text = durationFormatter.string(from: video.duration)
        videoTagLabel.text = video.tag
    }
    
    private func loadVideoThumbnai(with videoUrl: String) {
        guard let url = URL(string: videoUrl) else {
            videoThumbnailImageView.image = UIImage(named: "triangle")
            return
        }
        
        activityIndicator.startAnimating()
        
        thumbnailOperation?.cancel()
        
        thumbnailOperation = ThumbnailOperation(url: url) { [weak self] image in
            self?.activityIndicator.stopAnimating()
            self?.videoThumbnailImageView.image = image
        }
        
        OperationQueue().addOperation(thumbnailOperation!)
    }
    
    
    private func getThumnailFromVideo(url: URL, completion: @escaping ((_ image: UIImage?)-> Void)) {
        DispatchQueue.global().async {
            let asset = AVAsset(url: url)
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            avAssetImageGenerator.appliesPreferredTrackTransform = true
            
            let thumbnailTime = CMTimeMake(value: 7, timescale: 1)
            
            do {
                
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumbnailTime, actualTime: nil)
                let thumbImage = UIImage(cgImage: cgThumbImage)
                
                DispatchQueue.main.async {
                    completion(thumbImage)
                }
                
            } catch {
                print("DEBUG: error creating video thumbnail image getThumnailFromVideo() => \(error.localizedDescription)")
            }
            
        }
    }
    
    var thumbnailOperation: ThumbnailOperation?

}


class ThumbnailOperation: Operation {
    var url: URL
    var completion: ((UIImage?) -> Void)?
    
    init(url: URL, completion: @escaping ((UIImage?) -> Void)) {
        self.url = url
        self.completion = completion
    }
    
    override func main() {
        let asset = AVAsset(url: url)
        let avAssetImageGenerator = AVAssetImageGenerator(asset: asset)
        avAssetImageGenerator.appliesPreferredTrackTransform = true
        
        let thumnailTime = CMTimeMake(value: 2, timescale: 1)
        
        do {
            let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil)
            let thumbnailImage = UIImage(cgImage: cgThumbImage)
            
            DispatchQueue.main.async {
                if !self.isCancelled {
                    self.completion?(thumbnailImage)
                }
            }
        } catch {
            print("DEBUG: error getThumbnailFromVideo() => \(error.localizedDescription)")
            DispatchQueue.main.async {
                if !self.isCancelled {
                    self.completion?(nil)
                }
            }
        }
    }
}


