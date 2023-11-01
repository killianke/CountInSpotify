//
//  DiskStorage.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 10/10/2023.
//

import Foundation

typealias Handler<T> = (Result<T, Error>) -> Void

protocol ReadableStorage {
    func fetchValue(for key: String) throws -> Data
    func fetchValueAsync(for key: String) async throws -> Data
}

protocol WritableStorage {
    func save(value: Data, for key: String) throws
    func saveAsync(value: Data, for key: String) async throws -> Data
}

typealias Storage = ReadableStorage & WritableStorage

enum StorageError: Error {
    case notFound
    case cantWrite(Error)
}

class DiskStorage {
    private let queue: DispatchQueue
    private let fileManager: FileManager
    private let path: URL
    
    init(path: URL = URL.documentsDirectory,
         queue: DispatchQueue = .init(label: "DiskStorage.Queue"),
         fileManager: FileManager = FileManager.default) {
        self.path = path
        self.queue = queue
        self.fileManager = fileManager
    }
}

extension DiskStorage: WritableStorage {
    func save(value: Data, for key: String) throws {
        let url = path.appendingPathComponent(key)
        do {
            try self.createFolders(in: url)
            try value.write(to: url, options: .atomic)
        } catch {
            throw StorageError.cantWrite(error)
        }
    }
    
    func saveAsync(value: Data, for key: String) async throws -> Data {
        let writeTask = Task(priority: .background) {
            try self.save(value: value, for: key)
            return value
        }
        return try await writeTask.value
    }

    private func createFolders(in url: URL) throws {
        let folderUrl = url.deletingLastPathComponent()
        if !fileManager.fileExists(atPath: folderUrl.path) {
            try fileManager.createDirectory(
                at: folderUrl,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
    }
}

extension DiskStorage: ReadableStorage {
    func fetchValue(for key: String) throws -> Data {
        let url = path.appendingPathComponent(key)
        guard let data = fileManager.contents(atPath: url.path) else {
            throw StorageError.notFound
        }
        return data
    }

    func fetchValueAsync(for key: String) async throws -> Data {
        let fetchTask = Task(priority: .userInitiated) {
            try self.fetchValue(for: key)
        }
        return try await fetchTask.value
    }
}
