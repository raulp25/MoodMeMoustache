//
//  HTTPClient.swift
//  rs5
//
//  Created by Raul Pena on 22/04/24.
//

import Foundation

protocol HTTPClient {
    func perform(request: URLRequest) async throws -> (data: Data, response: HTTPURLResponse)
}

extension URLSession: HTTPClient {
    func perform(request: URLRequest) async throws -> (data: Data, response: HTTPURLResponse) {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        return (data, response)
    }
}

enum APIError: Error {
    case invalidResponse
    case notFound
    case unauthorized
    case normalError(error: Error)
}
