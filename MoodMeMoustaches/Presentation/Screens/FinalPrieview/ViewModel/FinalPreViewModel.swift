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
            let video = Video(id: UUID().uuidString, 
                              videoUrl: url,
                              duration: duration,
                              tag: tag,
                              timestamp: Timestamp(date: Date())
            )
            guard let id = video.id else { return }
            let data = [
                "id": id,
                "videoUrl": video.videoUrl,
                "duration": video.duration,
                "tag": video.tag,
                "timestamp": video.timestamp
            ] as [String: Any]
            
            try await Firestore.firestore().collection("videos").document(id).setData(data)
            print("DEBUG: uplaoding video finished =>")
        } catch {
            print("DEBUG: error uploading video uploadVideo() => \(error.localizedDescription)")
        }
    }
}
