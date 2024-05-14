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
    
    weak var delegate: VideoFeedViewModelDelegate?
    
    init() {
        
    }
    
    func getAllVideos() async {
        do {
            let snapshot = try await Firestore.firestore().collection("videos").getDocuments()
            self.videos = snapshot.documents.compactMap({ try? $0.data(as: Video.self) })
            print("DEBUG: called getAllVideos(): => \(videos.count)")
        } catch {
            print("DEBUG: error getAllVideos() => \(error)")
        }
    }
}



