//
//  Rocket.swift
//  rs5
//
//  Created by Raul Pena on 22/04/24.
//

import Foundation

struct Rocket: Decodable {
    let flickrImages: [String]?
    let name: String?
    let description, id: String?

    enum CodingKeys: String, CodingKey {
        case flickrImages = "flickr_images"
        case name, description, id
    }
}
