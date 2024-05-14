//
//  Video.swift
//  MoodMeMoustaches
//
//  Created by Raul Pena on 14/05/24.
//

import Foundation
import FirebaseFirestore

struct Video: Codable {
    @DocumentID var id: String? = UUID().uuidString
    var videoUrl: String
    var duration: Double
    var tag: String
    var timestamp: Timestamp
}
