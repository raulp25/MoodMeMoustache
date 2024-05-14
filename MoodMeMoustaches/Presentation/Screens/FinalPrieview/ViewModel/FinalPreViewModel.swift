//
//  FinalPreViewModel.swift
//  MoodMeMoustaches
//
//  Created by Raul Pena on 12/05/24.
//

import Foundation
import Firebase
import FirebaseFirestore

final class FinalPreViewViewModel {
    
    var tag: String = ""
    
    private let service: VideoFeedService
    
    init(service: VideoFeedService) {
        self.service = service
    }
    
    func uploadVideo(url: URL, duration: Double, tag: String) async {
        
        do {
            try await service.uploadVideo(url: url, duration: duration, tag: tag)
        } catch {
            print("DEBUG: error uploading video uploadVideo() => \(error.localizedDescription)")
        }
    }
}
