//
//  FinalPreViewModel.swift
//  rs5
//
//  Created by Raul Pena on 12/05/24.
//

import Foundation
import Firebase
import FirebaseFirestore

final class FinalPreViewViewModel {
    
    var tag: String = ""
    
    func uploadVideo(url: URL, duration: Double, tag: String) async {
        
        do {
            let videoData = try Data(contentsOf: url)
            let url = try await VideoUploader.uploadVideo(withData: videoData)
            
            guard let url = url else { return }
            let video = Video(videoUrl: url, duration: duration, tag: tag)
            let data = [
                "id": video.id,
                "videoUrl": video.videoUrl,
                "duration": video.duration,
                "tag": video.tag
            ] as [String: Any]
            
            try await Firestore.firestore().collection("videos").document(video.id).setData(data)
            print("DEBUG: uplaoding video finished =>")
        } catch {
            print("DEBUG: error uploading video uploadVideo() => \(error.localizedDescription)")
        }
    }
}
