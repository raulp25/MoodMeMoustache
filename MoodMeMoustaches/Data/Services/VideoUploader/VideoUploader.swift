//
//  VideoUploader.swift
//  rs5
//
//  Created by Raul Pena on 12/05/24.
//

import Foundation
import FirebaseStorage
import Firebase

struct VideoUploader {
    static func uploadVideo(withData videoData: Data) async throws -> String? {
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference().child("/videos\(filename)")
        let metadata = StorageMetadata()
        metadata.contentType = "video/quicktime"
        
        let _ = try await ref.putDataAsync(videoData, metadata: metadata)
        let url = try await ref.downloadURL()
        return url.absoluteString
    }
}
