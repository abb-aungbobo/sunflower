//
//  JSON.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 01/03/2024.
//

import Foundation

enum JSON {
    static func decode<T: Codable>(from file: String) throws -> T {
        guard let url = Bundle.main.url(forResource: file, withExtension: "json") else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
