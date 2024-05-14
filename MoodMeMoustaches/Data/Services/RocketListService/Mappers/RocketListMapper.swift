//
//  RocketListMapper.swift
//  rs5
//
//  Created by Raul Pena on 22/04/24.
//

import Foundation


struct RocketListMapper {
    static func map(data: Data, response: HTTPURLResponse, decodingStrategy: JSONDecoder = JSONDecoder()) throws -> [Rocket] {
        if (200...299) ~= response.statusCode {
            return try decodingStrategy.decode([Rocket].self, from: data)
        }
        
        if (300...399) ~= response.statusCode {
            throw APIError.invalidResponse
        }
        
        if (400...499) ~= response.statusCode {
            throw APIError.notFound
        }
        
        if (500...599) ~= response.statusCode {
            throw APIError.normalError(error: URLError(.badServerResponse))
        }
        
        throw APIError.invalidResponse
    }
}
