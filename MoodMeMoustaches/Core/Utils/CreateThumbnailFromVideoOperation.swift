//
//  CreateThumbnailFromVideoOperation.swift
//  MoodMeMoustaches
//
//  Created by Raul Pena on 14/05/24.
//

import Foundation
import AVKit

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
