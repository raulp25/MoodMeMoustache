//
//  VideoFeedViewModel.swift
//  MoodMeMoustaches
//
//  Created by Raul Pena on 14/05/24.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol VideoFeedViewModelDelegate: AnyObject {
    func videosDidChange()
}

final class VideoFeedViewModel {
    
    private(set) var videos = [Video]() {
        didSet {
            delegate?.videosDidChange()
        }
    }
    
    private let service: VideoFeedService
    
    var isLoading = false
    
    weak var delegate: VideoFeedViewModelDelegate?
    
    init(service: VideoFeedService) {
        self.service = service
    }
    
    func getAllVideos() async {
        defer { isLoading = false }
        isLoading = true
        
        do {
            self.videos = try await service.getAllVideos()
        } catch {
            print("DEBUG: error getAllVideos() => \(error)")
        }
    }
    
    func update(tag: String, for videoIndex: Int) {
        let tag = tag.trimWhiteSpaces()
        videos[videoIndex].tag = tag
    }
}



