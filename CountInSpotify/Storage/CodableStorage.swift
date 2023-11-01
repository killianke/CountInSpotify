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

    func fetch<T: Decodable>(for key: String, handler: @escaping Handler<T>) {
        storage.fetchValue(for: key, handler: { result in
            switch result {
            case .success(let data):
                do {
                    let decodedObject = try self.decoder.decode(T.self, from: data)
                    handler(.success(decodedObject))
                } catch let error {
                    handler(.failure(error))
                }
            case .failure(let error):
                handler(.failure(error))
            }
        })
    }
    
    func save<T: Encodable>(_ value: T, for key: String, errorHandler: @escaping (Error) -> Void) {
        do {
            let data = try encoder.encode(value)
            storage.save(value: data, for: key, handler: { result in
                if case .failure(let error) = result {
                    errorHandler(error)
                }
            })
        } catch let error {
            errorHandler(error)
        }
    }
}
