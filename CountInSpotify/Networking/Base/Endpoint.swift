//
//  RequestPath.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 02/10/2023.
//

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var queries: [URLQueryItem]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
}
