//
//  RocketListService.swift
//  rs5
//
//  Created by Raul Pena on 22/04/24.
//

import Foundation


protocol RocketListServiceProtocol {
    var client: HTTPClient { get }
    func getAllRockets() async throws -> [Rocket]
}

final class RocketListService: RocketListServiceProtocol {

    var client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func getAllRockets() async throws -> [Rocket] {
        let (data, response) = try await client.perform(request: MockRocketListRequest.makeRequest())
        return try RocketListMapper.map(data: data, response: response)
    }
}

struct MockRocketListRequest {
    static private let baseUrl = "https://api.spacexdata.com"
    static private let version = "/v4"
    static private let rocketPath = "/rockets"
    
    static func makeRequest() -> URLRequest {
        var baseUrl = URL(string: self.baseUrl)!
        baseUrl.append(path: version)
        baseUrl.append(path: rocketPath)
        
        return URLRequest(url: baseUrl, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
    }
    
}
