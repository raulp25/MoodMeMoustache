//
//  EditVideoViewModel.swift
//  MoodMeMoustaches
//
//  Created by Raul Pena on 14/05/24.
//

import Foundation
import FirebaseFirestore

class EditVideoViewModel {
    
    let video: Video
    let videoIndex: Int
    
    init(video: Video, videoIndex: Int) {
        self.video = video
        self.videoIndex = videoIndex
    }
    
    func update(tag: String, video: Video) async {
        let tag = tag.trimWhiteSpaces()
        
        do {
            let data = [
                "tag": tag
            ] as [String: Any]
            guard let id = video.id else { return }
            try await Firestore.firestore().collection("videos").document(id).updateData(data)
            print("DEBUG: uplaoding video finished =>")
        } catch {
            print("DEBUG: error uploading video uploadVideo() => \(error.localizedDescription)")
        }
    }
}
