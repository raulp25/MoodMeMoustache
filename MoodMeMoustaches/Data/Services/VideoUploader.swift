//
//  VideoUploader.swift
//  rs5
//
//  Created by Raul Pena on 12/05/24.
//

import Foundation

struct VideoUploader {
    static func uploadVideo(withData videoData: Data) async throws -> String? {
        
        let filename = NSUUID().uuidString
//        let ref = Storage.storage().referfence.child("/videos\(filename)")
//        let metadata = StorageMedata()
//        metadata.contentType = "video/quicktime"
        
    }
}
