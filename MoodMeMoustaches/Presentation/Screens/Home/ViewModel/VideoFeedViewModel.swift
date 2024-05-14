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
    
    var isLoading = false
    
    weak var delegate: VideoFeedViewModelDelegate?
    
    init() {
        
    }
    
    func getAllVideos() async {
        defer { isLoading = false }
        isLoading = true
        do {
            let snapshot = try await Firestore.firestore().collection("videos").getDocuments()
            self.videos = snapshot.documents.compactMap({ try? $0.data(as: Video.self) })
        } catch {
            print("DEBUG: error getAllVideos() => \(error)")
        }
    }
    
    func update(tag: String, for videoIndex: Int) {
        let tag = tag.trimWhiteSpaces()
        videos[videoIndex].tag = tag
    }
}



