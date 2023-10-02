//
//  SpotifyAlbum.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 01/10/2023.
//

import Foundation

struct SpotifyAlbum: Codable {
    var totalTracks: Int
    var id: String
    var name: String
    var releaseDate: String
    
    private enum CodingKeys : String, CodingKey {
        case totalTracks = "total_tracks"
        case id
        case name
        case releaseDate = "release_date"
    }    
}

/*
 {
 "album_type": "single",
 "total_tracks": 1,
 "available_markets": [],
 "external_urls": {
 "spotify": "https://open.spotify.com/album/0tGPJ0bkWOUmH7MEOR77qc"
 },
 "href": "https://api.spotify.com/v1/albums/0tGPJ0bkWOUmH7MEOR77qc",
 "id": "0tGPJ0bkWOUmH7MEOR77qc",
 "images": [
 {
 "url": "https://i.scdn.co/image/ab67616d0000b2737359994525d219f64872d3b1",
 "height": 640,
 "width": 640
 },
 {
 "url": "https://i.scdn.co/image/ab67616d00001e027359994525d219f64872d3b1",
 "height": 300,
 "width": 300
 },
 {
 "url": "https://i.scdn.co/image/ab67616d000048517359994525d219f64872d3b1",
 "height": 64,
 "width": 64
 }
 ],
 "name": "Cut To The Feeling",
 "release_date": "2017-05-26",
 "release_date_precision": "day",
 "type": "album",
 "uri": "spotify:album:0tGPJ0bkWOUmH7MEOR77qc",
 "artists": [
 {
 "external_urls": {
 "spotify": "https://open.spotify.com/artist/6sFIWsNpZYqfjUpaCgueju"
 },
 "href": "https://api.spotify.com/v1/artists/6sFIWsNpZYqfjUpaCgueju",
 "id": "6sFIWsNpZYqfjUpaCgueju",
 "name": "Carly Rae Jepsen",
 "type": "artist",
 "uri": "spotify:artist:6sFIWsNpZYqfjUpaCgueju"
 }
 ]
 }
 */
