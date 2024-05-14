//  MoodMeMoustaches

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol VideoFeedServiceProtocl {
    func getAllVideos() async throws -> [Video]
    func update(tag: String, video: Video) async throws
    func uploadVideo(url: URL, duration: Double, tag: String) async throws
}

final class VideoFeedService: VideoFeedServiceProtocl {
    
    func getAllVideos() async throws -> [Video] {
        let snapshot = try await Firestore.firestore().collection(fb_video_collection).getDocuments()
        let videos = snapshot.documents.compactMap({ try? $0.data(as: Video.self) })
        return videos.sorted { $0.timestamp.dateValue() > $1.timestamp.dateValue() }
    }
    
    func update(tag: String, video: Video) async throws {
        let data = [
            "tag": tag
        ] as [String: Any]
        
        guard let id = video.id else { return }
        try await Firestore.firestore().collection(fb_video_collection).document(id).updateData(data)
    }
    
    func uploadVideo(url: URL, duration: Double, tag: String) async throws {
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
        
        try await Firestore.firestore().collection(fb_video_collection).document(id).setData(data)
    }
    
}
