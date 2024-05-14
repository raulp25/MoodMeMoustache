//
//  Video.swift
//  MoodMeMoustaches
//
//  Created by Raul Pena on 14/05/24.
//

import Foundation

struct Video: Codable {
    var id: String = NSUUID().uuidString
    var videoUrl: String
    var duration: Double
    var tag: String
}
