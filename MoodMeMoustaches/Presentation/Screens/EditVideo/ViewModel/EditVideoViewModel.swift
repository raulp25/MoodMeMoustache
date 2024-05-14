//
//  EditVideoViewModel.swift
//  MoodMeMoustaches
//
//  Created by Raul Pena on 14/05/24.
//

import Foundation
import FirebaseFirestore

final class EditVideoViewModel {
    
    private var service: VideoFeedService
    
    let video: Video
    let videoIndex: Int
    
    init(video: Video, videoIndex: Int, service: VideoFeedService) {
        self.video = video
        self.videoIndex = videoIndex
        self.service = service
    }
    
    func update(tag: String, video: Video) async {
        let tag = tag.trimWhiteSpaces()
        
        do {
            try await service.update(tag: tag, video: video)
        } catch {
            print("DEBUG: error uploading video uploadVideo() => \(error.localizedDescription)")
        }
    }
}
