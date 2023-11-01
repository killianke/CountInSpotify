//
//  CodableStorage.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 10/10/2023.
//

import Foundation

class CodableStorage {
    private let storage: DiskStorage
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    init(storage: DiskStorage,
         decoder: JSONDecoder = .init(),
         encoder: JSONEncoder = .init()) {
        self.storage = storage
        self.decoder = decoder
        self.encoder = encoder
    }
    
    func fetch<T: Decodable>(for key: String) throws -> T {
        let data = try storage.fetchValue(for: key)
        return try decoder.decode(T.self, from: data)
    }
    
    func save<T: Encodable>(_ value: T, for key: String) throws {
        let data = try encoder.encode(value)
        try storage.save(value: data, for: key)
    }
    
    func fetchAsync<T: Decodable>(for key: String) async throws -> T {
        let data = try await storage.fetchValueAsync(for: key)
        return try self.decoder.decode(T.self, from: data)
    }
        
    func saveAsync<T: Encodable>(_ value: T, for key: String) async throws {
        let data = try encoder.encode(value)
        let _ = try await storage.saveAsync(value: data, for: key)
    }
}
