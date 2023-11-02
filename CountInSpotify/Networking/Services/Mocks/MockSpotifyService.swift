//
//  MockSpotifyService.swift
//  CountInSpotify
//
//  Created by Killian-Kenny on 02/11/2023.
//

import Foundation

struct MockSpotifyService: SpotifyServiceable {
    
    func getTopTracks() async -> Result<TopTracksResponse, RequestError> {
        return .success(response(of: TopTracksResponse.self, from: topTracksResponseString))
    }
    
    func searchTracks(with query: String, offset: Int, limit: Int) async -> Result<SearchResult, RequestError> {
        return .success(response(of: SearchResult.self, from: searchResponseString))
    }
    
    func getAudioAnalysisForTrack(withId trackId: String) async -> Result<AudioAnalysis, RequestError> {
        return .success(response(of: AudioAnalysis.self, from: audioAnalysisResponseString))
    }
    
    private func response<T: Decodable>(of type: T.Type, from string: String) -> T {
        let data = string.data(using: .utf8)!
        return try! JSONDecoder().decode(T.self, from: data)
    }
    
    private let topTracksResponseString = """
    {
      "tracks": {
        "href": "https://api.spotify.com/v1/search?query=emotion+sickness&type=track&market=IE&locale=en-GB%2Cen%3Bq%3D0.9&offset=0&limit=5",
        "items": [
          {
            "album": {
              "album_type": "single",
              "artists": [
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/4pejUc4iciQfgdX6OKulQn"
                  },
                  "href": "https://api.spotify.com/v1/artists/4pejUc4iciQfgdX6OKulQn",
                  "id": "4pejUc4iciQfgdX6OKulQn",
                  "name": "Queens of the Stone Age",
                  "type": "artist",
                  "uri": "spotify:artist:4pejUc4iciQfgdX6OKulQn"
                }
              ],
              "external_urls": {
                "spotify": "https://open.spotify.com/album/3dTSDhT6cUg4YxQTMRgf6S"
              },
              "href": "https://api.spotify.com/v1/albums/3dTSDhT6cUg4YxQTMRgf6S",
              "id": "3dTSDhT6cUg4YxQTMRgf6S",
              "images": [
                {
                  "height": 640,
                  "url": "https://i.scdn.co/image/ab67616d0000b273b60d2e2e459d09aea6205ecf",
                  "width": 640
                },
                {
                  "height": 300,
                  "url": "https://i.scdn.co/image/ab67616d00001e02b60d2e2e459d09aea6205ecf",
                  "width": 300
                },
                {
                  "height": 64,
                  "url": "https://i.scdn.co/image/ab67616d00004851b60d2e2e459d09aea6205ecf",
                  "width": 64
                }
              ],
              "is_playable": true,
              "name": "Emotion Sickness",
              "release_date": "2023-05-11",
              "release_date_precision": "day",
              "total_tracks": 1,
              "type": "album",
              "uri": "spotify:album:3dTSDhT6cUg4YxQTMRgf6S"
            },
            "artists": [
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/4pejUc4iciQfgdX6OKulQn"
                },
                "href": "https://api.spotify.com/v1/artists/4pejUc4iciQfgdX6OKulQn",
                "id": "4pejUc4iciQfgdX6OKulQn",
                "name": "Queens of the Stone Age",
                "type": "artist",
                "uri": "spotify:artist:4pejUc4iciQfgdX6OKulQn"
              }
            ],
            "disc_number": 1,
            "duration_ms": 271076,
            "explicit": true,
            "external_ids": {
              "isrc": "USMTD2200636"
            },
            "external_urls": {
              "spotify": "https://open.spotify.com/track/0qhGOjVl3uY2N6CAafVmCa"
            },
            "href": "https://api.spotify.com/v1/tracks/0qhGOjVl3uY2N6CAafVmCa",
            "id": "0qhGOjVl3uY2N6CAafVmCa",
            "is_local": false,
            "is_playable": true,
            "name": "Emotion Sickness",
            "popularity": 56,
            "preview_url": "https://p.scdn.co/mp3-preview/93a8849b63d53633b6f4b0e8395af9d090a7885f?cid=0ad54630510047d288157ea602078764",
            "track_number": 1,
            "type": "track",
            "uri": "spotify:track:0qhGOjVl3uY2N6CAafVmCa"
          },
          {
            "album": {
              "album_type": "album",
              "artists": [
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/4iudEcmuPlYNdbP3e1bdn1"
                  },
                  "href": "https://api.spotify.com/v1/artists/4iudEcmuPlYNdbP3e1bdn1",
                  "id": "4iudEcmuPlYNdbP3e1bdn1",
                  "name": "Silverchair",
                  "type": "artist",
                  "uri": "spotify:artist:4iudEcmuPlYNdbP3e1bdn1"
                }
              ],
              "external_urls": {
                "spotify": "https://open.spotify.com/album/28yAJqJJ0iz1oRqwOD0F20"
              },
              "href": "https://api.spotify.com/v1/albums/28yAJqJJ0iz1oRqwOD0F20",
              "id": "28yAJqJJ0iz1oRqwOD0F20",
              "images": [
                {
                  "height": 640,
                  "url": "https://i.scdn.co/image/ab67616d0000b2731b0201a6273523f60b8b5406",
                  "width": 640
                },
                {
                  "height": 300,
                  "url": "https://i.scdn.co/image/ab67616d00001e021b0201a6273523f60b8b5406",
                  "width": 300
                },
                {
                  "height": 64,
                  "url": "https://i.scdn.co/image/ab67616d000048511b0201a6273523f60b8b5406",
                  "width": 64
                }
              ],
              "is_playable": true,
              "name": "Neon Ballroom",
              "release_date": "1999",
              "release_date_precision": "year",
              "total_tracks": 12,
              "type": "album",
              "uri": "spotify:album:28yAJqJJ0iz1oRqwOD0F20"
            },
            "artists": [
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/4iudEcmuPlYNdbP3e1bdn1"
                },
                "href": "https://api.spotify.com/v1/artists/4iudEcmuPlYNdbP3e1bdn1",
                "id": "4iudEcmuPlYNdbP3e1bdn1",
                "name": "Silverchair",
                "type": "artist",
                "uri": "spotify:artist:4iudEcmuPlYNdbP3e1bdn1"
              }
            ],
            "disc_number": 1,
            "duration_ms": 360813,
            "explicit": false,
            "external_ids": {
              "isrc": "AUSM09800223"
            },
            "external_urls": {
              "spotify": "https://open.spotify.com/track/37XF41xuNT4t1Gqy99R7dA"
            },
            "href": "https://api.spotify.com/v1/tracks/37XF41xuNT4t1Gqy99R7dA",
            "id": "37XF41xuNT4t1Gqy99R7dA",
            "is_local": false,
            "is_playable": true,
            "name": "Emotion Sickness",
            "popularity": 37,
            "preview_url": "https://p.scdn.co/mp3-preview/10891a11ae57077bbbccd0be4f572951c58cdac7?cid=0ad54630510047d288157ea602078764",
            "track_number": 1,
            "type": "track",
            "uri": "spotify:track:37XF41xuNT4t1Gqy99R7dA"
          },
          {
            "album": {
              "album_type": "album",
              "artists": [
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/4pejUc4iciQfgdX6OKulQn"
                  },
                  "href": "https://api.spotify.com/v1/artists/4pejUc4iciQfgdX6OKulQn",
                  "id": "4pejUc4iciQfgdX6OKulQn",
                  "name": "Queens of the Stone Age",
                  "type": "artist",
                  "uri": "spotify:artist:4pejUc4iciQfgdX6OKulQn"
                }
              ],
              "external_urls": {
                "spotify": "https://open.spotify.com/album/2ZTDmH94OLjeNaOvT7Ngwk"
              },
              "href": "https://api.spotify.com/v1/albums/2ZTDmH94OLjeNaOvT7Ngwk",
              "id": "2ZTDmH94OLjeNaOvT7Ngwk",
              "images": [
                {
                  "height": 640,
                  "url": "https://i.scdn.co/image/ab67616d0000b273df1999f84b4c1981ba570d17",
                  "width": 640
                },
                {
                  "height": 300,
                  "url": "https://i.scdn.co/image/ab67616d00001e02df1999f84b4c1981ba570d17",
                  "width": 300
                },
                {
                  "height": 64,
                  "url": "https://i.scdn.co/image/ab67616d00004851df1999f84b4c1981ba570d17",
                  "width": 64
                }
              ],
              "is_playable": true,
              "name": "In Times New Roman...",
              "release_date": "2023-06-16",
              "release_date_precision": "day",
              "total_tracks": 10,
              "type": "album",
              "uri": "spotify:album:2ZTDmH94OLjeNaOvT7Ngwk"
            },
            "artists": [
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/4pejUc4iciQfgdX6OKulQn"
                },
                "href": "https://api.spotify.com/v1/artists/4pejUc4iciQfgdX6OKulQn",
                "id": "4pejUc4iciQfgdX6OKulQn",
                "name": "Queens of the Stone Age",
                "type": "artist",
                "uri": "spotify:artist:4pejUc4iciQfgdX6OKulQn"
              }
            ],
            "disc_number": 1,
            "duration_ms": 271076,
            "explicit": true,
            "external_ids": {
              "isrc": "USMTD2200636"
            },
            "external_urls": {
              "spotify": "https://open.spotify.com/track/5a8V2ZeVLj8ktvodCa1m80"
            },
            "href": "https://api.spotify.com/v1/tracks/5a8V2ZeVLj8ktvodCa1m80",
            "id": "5a8V2ZeVLj8ktvodCa1m80",
            "is_local": false,
            "is_playable": true,
            "name": "Emotion Sickness",
            "popularity": 56,
            "preview_url": "https://p.scdn.co/mp3-preview/93a8849b63d53633b6f4b0e8395af9d090a7885f?cid=0ad54630510047d288157ea602078764",
            "track_number": 9,
            "type": "track",
            "uri": "spotify:track:5a8V2ZeVLj8ktvodCa1m80"
          },
          {
            "album": {
              "album_type": "album",
              "artists": [
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/4LZ4De2MoO3lP6QaNCfvcu"
                  },
                  "href": "https://api.spotify.com/v1/artists/4LZ4De2MoO3lP6QaNCfvcu",
                  "id": "4LZ4De2MoO3lP6QaNCfvcu",
                  "name": "Said The Sky",
                  "type": "artist",
                  "uri": "spotify:artist:4LZ4De2MoO3lP6QaNCfvcu"
                }
              ],
              "external_urls": {
                "spotify": "https://open.spotify.com/album/4eZHJqBC68gC2UtAKeiCnA"
              },
              "href": "https://api.spotify.com/v1/albums/4eZHJqBC68gC2UtAKeiCnA",
              "id": "4eZHJqBC68gC2UtAKeiCnA",
              "images": [
                {
                  "height": 640,
                  "url": "https://i.scdn.co/image/ab67616d0000b2731da2e316376d4701ace02c53",
                  "width": 640
                },
                {
                  "height": 300,
                  "url": "https://i.scdn.co/image/ab67616d00001e021da2e316376d4701ace02c53",
                  "width": 300
                },
                {
                  "height": 64,
                  "url": "https://i.scdn.co/image/ab67616d000048511da2e316376d4701ace02c53",
                  "width": 64
                }
              ],
              "is_playable": true,
              "name": "Sentiment",
              "release_date": "2022-02-18",
              "release_date_precision": "day",
              "total_tracks": 15,
              "type": "album",
              "uri": "spotify:album:4eZHJqBC68gC2UtAKeiCnA"
            },
            "artists": [
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/4LZ4De2MoO3lP6QaNCfvcu"
                },
                "href": "https://api.spotify.com/v1/artists/4LZ4De2MoO3lP6QaNCfvcu",
                "id": "4LZ4De2MoO3lP6QaNCfvcu",
                "name": "Said The Sky",
                "type": "artist",
                "uri": "spotify:artist:4LZ4De2MoO3lP6QaNCfvcu"
              },
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/2PCUhxD40qlMqsKHjTZD2e"
                },
                "href": "https://api.spotify.com/v1/artists/2PCUhxD40qlMqsKHjTZD2e",
                "id": "2PCUhxD40qlMqsKHjTZD2e",
                "name": "Parachute",
                "type": "artist",
                "uri": "spotify:artist:2PCUhxD40qlMqsKHjTZD2e"
              },
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/3jASw3YQHarl90fZWNyCdn"
                },
                "href": "https://api.spotify.com/v1/artists/3jASw3YQHarl90fZWNyCdn",
                "id": "3jASw3YQHarl90fZWNyCdn",
                "name": "Will Anderson",
                "type": "artist",
                "uri": "spotify:artist:3jASw3YQHarl90fZWNyCdn"
              }
            ],
            "disc_number": 1,
            "duration_ms": 202493,
            "explicit": false,
            "external_ids": {
              "isrc": "GBKPL2282216"
            },
            "external_urls": {
              "spotify": "https://open.spotify.com/track/5NWyhQjPTh37ygOq4UHYZk"
            },
            "href": "https://api.spotify.com/v1/tracks/5NWyhQjPTh37ygOq4UHYZk",
            "id": "5NWyhQjPTh37ygOq4UHYZk",
            "is_local": false,
            "is_playable": true,
            "name": "Emotion Sickness",
            "popularity": 53,
            "preview_url": "https://p.scdn.co/mp3-preview/d5b92647bf5c1f2ed868313bcc8e4aa3e862a2de?cid=0ad54630510047d288157ea602078764",
            "track_number": 7,
            "type": "track",
            "uri": "spotify:track:5NWyhQjPTh37ygOq4UHYZk"
          },
          {
            "album": {
              "album_type": "album",
              "artists": [
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/00IiVt687EdR9JnSoJN7IA"
                  },
                  "href": "https://api.spotify.com/v1/artists/00IiVt687EdR9JnSoJN7IA",
                  "id": "00IiVt687EdR9JnSoJN7IA",
                  "name": "Mazza_l20",
                  "type": "artist",
                  "uri": "spotify:artist:00IiVt687EdR9JnSoJN7IA"
                }
              ],
              "external_urls": {
                "spotify": "https://open.spotify.com/album/5ZCSGeltEmsrr9zWuHv2Fs"
              },
              "href": "https://api.spotify.com/v1/albums/5ZCSGeltEmsrr9zWuHv2Fs",
              "id": "5ZCSGeltEmsrr9zWuHv2Fs",
              "images": [
                {
                  "height": 640,
                  "url": "https://i.scdn.co/image/ab67616d0000b273686efa27468c5b6757d1f36f",
                  "width": 640
                },
                {
                  "height": 300,
                  "url": "https://i.scdn.co/image/ab67616d00001e02686efa27468c5b6757d1f36f",
                  "width": 300
                },
                {
                  "height": 64,
                  "url": "https://i.scdn.co/image/ab67616d00004851686efa27468c5b6757d1f36f",
                  "width": 64
                }
              ],
              "is_playable": true,
              "name": "Concrete Jungle",
              "release_date": "2023-08-29",
              "release_date_precision": "day",
              "total_tracks": 12,
              "type": "album",
              "uri": "spotify:album:5ZCSGeltEmsrr9zWuHv2Fs"
            },
            "artists": [
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/00IiVt687EdR9JnSoJN7IA"
                },
                "href": "https://api.spotify.com/v1/artists/00IiVt687EdR9JnSoJN7IA",
                "id": "00IiVt687EdR9JnSoJN7IA",
                "name": "Mazza_l20",
                "type": "artist",
                "uri": "spotify:artist:00IiVt687EdR9JnSoJN7IA"
              }
            ],
            "disc_number": 1,
            "duration_ms": 224680,
            "explicit": true,
            "external_ids": {
              "isrc": "QZNWS2378569"
            },
            "external_urls": {
              "spotify": "https://open.spotify.com/track/4yr9gSPRZwH1G7EhrjQ6QN"
            },
            "href": "https://api.spotify.com/v1/tracks/4yr9gSPRZwH1G7EhrjQ6QN",
            "id": "4yr9gSPRZwH1G7EhrjQ6QN",
            "is_local": false,
            "is_playable": true,
            "name": "Emotional Scars",
            "popularity": 47,
            "preview_url": "https://p.scdn.co/mp3-preview/84c4abbde5e5669a7049c45c2cd3ab5cc990ac42?cid=0ad54630510047d288157ea602078764",
            "track_number": 2,
            "type": "track",
            "uri": "spotify:track:4yr9gSPRZwH1G7EhrjQ6QN"
          }
        ],
        "limit": 5,
        "next": "https://api.spotify.com/v1/search?query=emotion+sickness&type=track&market=IE&locale=en-GB%2Cen%3Bq%3D0.9&offset=5&limit=5",
        "offset": 0,
        "previous": null,
        "total": 804
      }
    }
    """
    
    private let searchResponseString = """
    {
      "tracks": {
        "href": "https://api.spotify.com/v1/search?query=emotion+sickness&type=track&market=IE&locale=en-GB%2Cen%3Bq%3D0.9&offset=0&limit=20",
        "items": [
          {
            "album": {
              "album_type": "single",
              "artists": [
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/4pejUc4iciQfgdX6OKulQn"
                  },
                  "href": "https://api.spotify.com/v1/artists/4pejUc4iciQfgdX6OKulQn",
                  "id": "4pejUc4iciQfgdX6OKulQn",
                  "name": "Queens of the Stone Age",
                  "type": "artist",
                  "uri": "spotify:artist:4pejUc4iciQfgdX6OKulQn"
                }
              ],
              "external_urls": {
                "spotify": "https://open.spotify.com/album/3dTSDhT6cUg4YxQTMRgf6S"
              },
              "href": "https://api.spotify.com/v1/albums/3dTSDhT6cUg4YxQTMRgf6S",
              "id": "3dTSDhT6cUg4YxQTMRgf6S",
              "images": [
                {
                  "height": 640,
                  "url": "https://i.scdn.co/image/ab67616d0000b273b60d2e2e459d09aea6205ecf",
                  "width": 640
                },
                {
                  "height": 300,
                  "url": "https://i.scdn.co/image/ab67616d00001e02b60d2e2e459d09aea6205ecf",
                  "width": 300
                },
                {
                  "height": 64,
                  "url": "https://i.scdn.co/image/ab67616d00004851b60d2e2e459d09aea6205ecf",
                  "width": 64
                }
              ],
              "is_playable": true,
              "name": "Emotion Sickness",
              "release_date": "2023-05-11",
              "release_date_precision": "day",
              "total_tracks": 1,
              "type": "album",
              "uri": "spotify:album:3dTSDhT6cUg4YxQTMRgf6S"
            },
            "artists": [
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/4pejUc4iciQfgdX6OKulQn"
                },
                "href": "https://api.spotify.com/v1/artists/4pejUc4iciQfgdX6OKulQn",
                "id": "4pejUc4iciQfgdX6OKulQn",
                "name": "Queens of the Stone Age",
                "type": "artist",
                "uri": "spotify:artist:4pejUc4iciQfgdX6OKulQn"
              }
            ],
            "disc_number": 1,
            "duration_ms": 271076,
            "explicit": true,
            "external_ids": {
              "isrc": "USMTD2200636"
            },
            "external_urls": {
              "spotify": "https://open.spotify.com/track/0qhGOjVl3uY2N6CAafVmCa"
            },
            "href": "https://api.spotify.com/v1/tracks/0qhGOjVl3uY2N6CAafVmCa",
            "id": "0qhGOjVl3uY2N6CAafVmCa",
            "is_local": false,
            "is_playable": true,
            "name": "Emotion Sickness",
            "popularity": 56,
            "preview_url": "https://p.scdn.co/mp3-preview/93a8849b63d53633b6f4b0e8395af9d090a7885f?cid=0ad54630510047d288157ea602078764",
            "track_number": 1,
            "type": "track",
            "uri": "spotify:track:0qhGOjVl3uY2N6CAafVmCa"
          },
          {
            "album": {
              "album_type": "album",
              "artists": [
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/4iudEcmuPlYNdbP3e1bdn1"
                  },
                  "href": "https://api.spotify.com/v1/artists/4iudEcmuPlYNdbP3e1bdn1",
                  "id": "4iudEcmuPlYNdbP3e1bdn1",
                  "name": "Silverchair",
                  "type": "artist",
                  "uri": "spotify:artist:4iudEcmuPlYNdbP3e1bdn1"
                }
              ],
              "external_urls": {
                "spotify": "https://open.spotify.com/album/75viR4DrKJUIH7wFvQ7PbB"
              },
              "href": "https://api.spotify.com/v1/albums/75viR4DrKJUIH7wFvQ7PbB",
              "id": "75viR4DrKJUIH7wFvQ7PbB",
              "images": [
                {
                  "height": 640,
                  "url": "https://i.scdn.co/image/ab67616d0000b273ad5c05fa4ba3c07d26364997",
                  "width": 640
                },
                {
                  "height": 300,
                  "url": "https://i.scdn.co/image/ab67616d00001e02ad5c05fa4ba3c07d26364997",
                  "width": 300
                },
                {
                  "height": 64,
                  "url": "https://i.scdn.co/image/ab67616d00004851ad5c05fa4ba3c07d26364997",
                  "width": 64
                }
              ],
              "is_playable": true,
              "name": "Neon Ballroom",
              "release_date": "1999-01-23",
              "release_date_precision": "day",
              "total_tracks": 12,
              "type": "album",
              "uri": "spotify:album:75viR4DrKJUIH7wFvQ7PbB"
            },
            "artists": [
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/4iudEcmuPlYNdbP3e1bdn1"
                },
                "href": "https://api.spotify.com/v1/artists/4iudEcmuPlYNdbP3e1bdn1",
                "id": "4iudEcmuPlYNdbP3e1bdn1",
                "name": "Silverchair",
                "type": "artist",
                "uri": "spotify:artist:4iudEcmuPlYNdbP3e1bdn1"
              }
            ],
            "disc_number": 1,
            "duration_ms": 360813,
            "explicit": false,
            "external_ids": {
              "isrc": "AUSM09800223"
            },
            "external_urls": {
              "spotify": "https://open.spotify.com/track/5ss8EKvZmxatWEAkbkkAsr"
            },
            "href": "https://api.spotify.com/v1/tracks/5ss8EKvZmxatWEAkbkkAsr",
            "id": "5ss8EKvZmxatWEAkbkkAsr",
            "is_local": false,
            "is_playable": true,
            "name": "Emotion Sickness",
            "popularity": 33,
            "preview_url": "https://p.scdn.co/mp3-preview/10891a11ae57077bbbccd0be4f572951c58cdac7?cid=0ad54630510047d288157ea602078764",
            "track_number": 1,
            "type": "track",
            "uri": "spotify:track:5ss8EKvZmxatWEAkbkkAsr"
          },
          {
            "album": {
              "album_type": "album",
              "artists": [
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/4pejUc4iciQfgdX6OKulQn"
                  },
                  "href": "https://api.spotify.com/v1/artists/4pejUc4iciQfgdX6OKulQn",
                  "id": "4pejUc4iciQfgdX6OKulQn",
                  "name": "Queens of the Stone Age",
                  "type": "artist",
                  "uri": "spotify:artist:4pejUc4iciQfgdX6OKulQn"
                }
              ],
              "external_urls": {
                "spotify": "https://open.spotify.com/album/2ZTDmH94OLjeNaOvT7Ngwk"
              },
              "href": "https://api.spotify.com/v1/albums/2ZTDmH94OLjeNaOvT7Ngwk",
              "id": "2ZTDmH94OLjeNaOvT7Ngwk",
              "images": [
                {
                  "height": 640,
                  "url": "https://i.scdn.co/image/ab67616d0000b273df1999f84b4c1981ba570d17",
                  "width": 640
                },
                {
                  "height": 300,
                  "url": "https://i.scdn.co/image/ab67616d00001e02df1999f84b4c1981ba570d17",
                  "width": 300
                },
                {
                  "height": 64,
                  "url": "https://i.scdn.co/image/ab67616d00004851df1999f84b4c1981ba570d17",
                  "width": 64
                }
              ],
              "is_playable": true,
              "name": "In Times New Roman...",
              "release_date": "2023-06-16",
              "release_date_precision": "day",
              "total_tracks": 10,
              "type": "album",
              "uri": "spotify:album:2ZTDmH94OLjeNaOvT7Ngwk"
            },
            "artists": [
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/4pejUc4iciQfgdX6OKulQn"
                },
                "href": "https://api.spotify.com/v1/artists/4pejUc4iciQfgdX6OKulQn",
                "id": "4pejUc4iciQfgdX6OKulQn",
                "name": "Queens of the Stone Age",
                "type": "artist",
                "uri": "spotify:artist:4pejUc4iciQfgdX6OKulQn"
              }
            ],
            "disc_number": 1,
            "duration_ms": 271076,
            "explicit": true,
            "external_ids": {
              "isrc": "USMTD2200636"
            },
            "external_urls": {
              "spotify": "https://open.spotify.com/track/5a8V2ZeVLj8ktvodCa1m80"
            },
            "href": "https://api.spotify.com/v1/tracks/5a8V2ZeVLj8ktvodCa1m80",
            "id": "5a8V2ZeVLj8ktvodCa1m80",
            "is_local": false,
            "is_playable": true,
            "name": "Emotion Sickness",
            "popularity": 56,
            "preview_url": "https://p.scdn.co/mp3-preview/93a8849b63d53633b6f4b0e8395af9d090a7885f?cid=0ad54630510047d288157ea602078764",
            "track_number": 9,
            "type": "track",
            "uri": "spotify:track:5a8V2ZeVLj8ktvodCa1m80"
          },
          {
            "album": {
              "album_type": "album",
              "artists": [
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/4iudEcmuPlYNdbP3e1bdn1"
                  },
                  "href": "https://api.spotify.com/v1/artists/4iudEcmuPlYNdbP3e1bdn1",
                  "id": "4iudEcmuPlYNdbP3e1bdn1",
                  "name": "Silverchair",
                  "type": "artist",
                  "uri": "spotify:artist:4iudEcmuPlYNdbP3e1bdn1"
                }
              ],
              "external_urls": {
                "spotify": "https://open.spotify.com/album/10bobqzP8mtragmflBolOM"
              },
              "href": "https://api.spotify.com/v1/albums/10bobqzP8mtragmflBolOM",
              "id": "10bobqzP8mtragmflBolOM",
              "images": [
                {
                  "height": 640,
                  "url": "https://i.scdn.co/image/ab67616d0000b27302629081ad3b70375352dd19",
                  "width": 640
                },
                {
                  "height": 300,
                  "url": "https://i.scdn.co/image/ab67616d00001e0202629081ad3b70375352dd19",
                  "width": 300
                },
                {
                  "height": 64,
                  "url": "https://i.scdn.co/image/ab67616d0000485102629081ad3b70375352dd19",
                  "width": 64
                }
              ],
              "is_playable": true,
              "name": "Neon Ballroom",
              "release_date": "1999-03-08",
              "release_date_precision": "day",
              "total_tracks": 12,
              "type": "album",
              "uri": "spotify:album:10bobqzP8mtragmflBolOM"
            },
            "artists": [
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/4iudEcmuPlYNdbP3e1bdn1"
                },
                "href": "https://api.spotify.com/v1/artists/4iudEcmuPlYNdbP3e1bdn1",
                "id": "4iudEcmuPlYNdbP3e1bdn1",
                "name": "Silverchair",
                "type": "artist",
                "uri": "spotify:artist:4iudEcmuPlYNdbP3e1bdn1"
              }
            ],
            "disc_number": 1,
            "duration_ms": 360813,
            "explicit": false,
            "external_ids": {
              "isrc": "AUSM09800223"
            },
            "external_urls": {
              "spotify": "https://open.spotify.com/track/3y7dENLRE8paSquq4LAW1e"
            },
            "href": "https://api.spotify.com/v1/tracks/3y7dENLRE8paSquq4LAW1e",
            "id": "3y7dENLRE8paSquq4LAW1e",
            "is_local": false,
            "is_playable": true,
            "name": "Emotion Sickness",
            "popularity": 39,
            "preview_url": "https://p.scdn.co/mp3-preview/10891a11ae57077bbbccd0be4f572951c58cdac7?cid=0ad54630510047d288157ea602078764",
            "track_number": 1,
            "type": "track",
            "uri": "spotify:track:3y7dENLRE8paSquq4LAW1e"
          },
          {
            "album": {
              "album_type": "album",
              "artists": [
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/4iudEcmuPlYNdbP3e1bdn1"
                  },
                  "href": "https://api.spotify.com/v1/artists/4iudEcmuPlYNdbP3e1bdn1",
                  "id": "4iudEcmuPlYNdbP3e1bdn1",
                  "name": "Silverchair",
                  "type": "artist",
                  "uri": "spotify:artist:4iudEcmuPlYNdbP3e1bdn1"
                }
              ],
              "external_urls": {
                "spotify": "https://open.spotify.com/album/28yAJqJJ0iz1oRqwOD0F20"
              },
              "href": "https://api.spotify.com/v1/albums/28yAJqJJ0iz1oRqwOD0F20",
              "id": "28yAJqJJ0iz1oRqwOD0F20",
              "images": [
                {
                  "height": 640,
                  "url": "https://i.scdn.co/image/ab67616d0000b2731b0201a6273523f60b8b5406",
                  "width": 640
                },
                {
                  "height": 300,
                  "url": "https://i.scdn.co/image/ab67616d00001e021b0201a6273523f60b8b5406",
                  "width": 300
                },
                {
                  "height": 64,
                  "url": "https://i.scdn.co/image/ab67616d000048511b0201a6273523f60b8b5406",
                  "width": 64
                }
              ],
              "is_playable": true,
              "name": "Neon Ballroom",
              "release_date": "1999",
              "release_date_precision": "year",
              "total_tracks": 12,
              "type": "album",
              "uri": "spotify:album:28yAJqJJ0iz1oRqwOD0F20"
            },
            "artists": [
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/4iudEcmuPlYNdbP3e1bdn1"
                },
                "href": "https://api.spotify.com/v1/artists/4iudEcmuPlYNdbP3e1bdn1",
                "id": "4iudEcmuPlYNdbP3e1bdn1",
                "name": "Silverchair",
                "type": "artist",
                "uri": "spotify:artist:4iudEcmuPlYNdbP3e1bdn1"
              }
            ],
            "disc_number": 1,
            "duration_ms": 360813,
            "explicit": false,
            "external_ids": {
              "isrc": "AUSM09800223"
            },
            "external_urls": {
              "spotify": "https://open.spotify.com/track/37XF41xuNT4t1Gqy99R7dA"
            },
            "href": "https://api.spotify.com/v1/tracks/37XF41xuNT4t1Gqy99R7dA",
            "id": "37XF41xuNT4t1Gqy99R7dA",
            "is_local": false,
            "is_playable": true,
            "name": "Emotion Sickness",
            "popularity": 37,
            "preview_url": "https://p.scdn.co/mp3-preview/10891a11ae57077bbbccd0be4f572951c58cdac7?cid=0ad54630510047d288157ea602078764",
            "track_number": 1,
            "type": "track",
            "uri": "spotify:track:37XF41xuNT4t1Gqy99R7dA"
          },
          {
            "album": {
              "album_type": "album",
              "artists": [
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/4LZ4De2MoO3lP6QaNCfvcu"
                  },
                  "href": "https://api.spotify.com/v1/artists/4LZ4De2MoO3lP6QaNCfvcu",
                  "id": "4LZ4De2MoO3lP6QaNCfvcu",
                  "name": "Said The Sky",
                  "type": "artist",
                  "uri": "spotify:artist:4LZ4De2MoO3lP6QaNCfvcu"
                }
              ],
              "external_urls": {
                "spotify": "https://open.spotify.com/album/4eZHJqBC68gC2UtAKeiCnA"
              },
              "href": "https://api.spotify.com/v1/albums/4eZHJqBC68gC2UtAKeiCnA",
              "id": "4eZHJqBC68gC2UtAKeiCnA",
              "images": [
                {
                  "height": 640,
                  "url": "https://i.scdn.co/image/ab67616d0000b2731da2e316376d4701ace02c53",
                  "width": 640
                },
                {
                  "height": 300,
                  "url": "https://i.scdn.co/image/ab67616d00001e021da2e316376d4701ace02c53",
                  "width": 300
                },
                {
                  "height": 64,
                  "url": "https://i.scdn.co/image/ab67616d000048511da2e316376d4701ace02c53",
                  "width": 64
                }
              ],
              "is_playable": true,
              "name": "Sentiment",
              "release_date": "2022-02-18",
              "release_date_precision": "day",
              "total_tracks": 15,
              "type": "album",
              "uri": "spotify:album:4eZHJqBC68gC2UtAKeiCnA"
            },
            "artists": [
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/4LZ4De2MoO3lP6QaNCfvcu"
                },
                "href": "https://api.spotify.com/v1/artists/4LZ4De2MoO3lP6QaNCfvcu",
                "id": "4LZ4De2MoO3lP6QaNCfvcu",
                "name": "Said The Sky",
                "type": "artist",
                "uri": "spotify:artist:4LZ4De2MoO3lP6QaNCfvcu"
              },
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/2PCUhxD40qlMqsKHjTZD2e"
                },
                "href": "https://api.spotify.com/v1/artists/2PCUhxD40qlMqsKHjTZD2e",
                "id": "2PCUhxD40qlMqsKHjTZD2e",
                "name": "Parachute",
                "type": "artist",
                "uri": "spotify:artist:2PCUhxD40qlMqsKHjTZD2e"
              },
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/3jASw3YQHarl90fZWNyCdn"
                },
                "href": "https://api.spotify.com/v1/artists/3jASw3YQHarl90fZWNyCdn",
                "id": "3jASw3YQHarl90fZWNyCdn",
                "name": "Will Anderson",
                "type": "artist",
                "uri": "spotify:artist:3jASw3YQHarl90fZWNyCdn"
              }
            ],
            "disc_number": 1,
            "duration_ms": 202493,
            "explicit": false,
            "external_ids": {
              "isrc": "GBKPL2282216"
            },
            "external_urls": {
              "spotify": "https://open.spotify.com/track/5NWyhQjPTh37ygOq4UHYZk"
            },
            "href": "https://api.spotify.com/v1/tracks/5NWyhQjPTh37ygOq4UHYZk",
            "id": "5NWyhQjPTh37ygOq4UHYZk",
            "is_local": false,
            "is_playable": true,
            "name": "Emotion Sickness",
            "popularity": 53,
            "preview_url": "https://p.scdn.co/mp3-preview/d5b92647bf5c1f2ed868313bcc8e4aa3e862a2de?cid=0ad54630510047d288157ea602078764",
            "track_number": 7,
            "type": "track",
            "uri": "spotify:track:5NWyhQjPTh37ygOq4UHYZk"
          },
          {
            "album": {
              "album_type": "single",
              "artists": [
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/4pejUc4iciQfgdX6OKulQn"
                  },
                  "href": "https://api.spotify.com/v1/artists/4pejUc4iciQfgdX6OKulQn",
                  "id": "4pejUc4iciQfgdX6OKulQn",
                  "name": "Queens of the Stone Age",
                  "type": "artist",
                  "uri": "spotify:artist:4pejUc4iciQfgdX6OKulQn"
                }
              ],
              "external_urls": {
                "spotify": "https://open.spotify.com/album/2UB1sEIK8wEhikbkcsIcIn"
              },
              "href": "https://api.spotify.com/v1/albums/2UB1sEIK8wEhikbkcsIcIn",
              "id": "2UB1sEIK8wEhikbkcsIcIn",
              "images": [
                {
                  "height": 640,
                  "url": "https://i.scdn.co/image/ab67616d0000b273ac65fae0afe49658e9f83a44",
                  "width": 640
                },
                {
                  "height": 300,
                  "url": "https://i.scdn.co/image/ab67616d00001e02ac65fae0afe49658e9f83a44",
                  "width": 300
                },
                {
                  "height": 64,
                  "url": "https://i.scdn.co/image/ab67616d00004851ac65fae0afe49658e9f83a44",
                  "width": 64
                }
              ],
              "is_playable": true,
              "name": "Carnavoyeur",
              "release_date": "2023-05-31",
              "release_date_precision": "day",
              "total_tracks": 2,
              "type": "album",
              "uri": "spotify:album:2UB1sEIK8wEhikbkcsIcIn"
            },
            "artists": [
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/4pejUc4iciQfgdX6OKulQn"
                },
                "href": "https://api.spotify.com/v1/artists/4pejUc4iciQfgdX6OKulQn",
                "id": "4pejUc4iciQfgdX6OKulQn",
                "name": "Queens of the Stone Age",
                "type": "artist",
                "uri": "spotify:artist:4pejUc4iciQfgdX6OKulQn"
              }
            ],
            "disc_number": 1,
            "duration_ms": 271076,
            "explicit": true,
            "external_ids": {
              "isrc": "USMTD2200636"
            },
            "external_urls": {
              "spotify": "https://open.spotify.com/track/1ZsOQzHmQrOc13CXm18G2s"
            },
            "href": "https://api.spotify.com/v1/tracks/1ZsOQzHmQrOc13CXm18G2s",
            "id": "1ZsOQzHmQrOc13CXm18G2s",
            "is_local": false,
            "is_playable": true,
            "name": "Emotion Sickness",
            "popularity": 36,
            "preview_url": "https://p.scdn.co/mp3-preview/93a8849b63d53633b6f4b0e8395af9d090a7885f?cid=0ad54630510047d288157ea602078764",
            "track_number": 2,
            "type": "track",
            "uri": "spotify:track:1ZsOQzHmQrOc13CXm18G2s"
          },
          {
            "album": {
              "album_type": "single",
              "artists": [
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/2n7USVO8fO8FF8zq4kG2N1"
                  },
                  "href": "https://api.spotify.com/v1/artists/2n7USVO8fO8FF8zq4kG2N1",
                  "id": "2n7USVO8fO8FF8zq4kG2N1",
                  "name": "Mat Zo",
                  "type": "artist",
                  "uri": "spotify:artist:2n7USVO8fO8FF8zq4kG2N1"
                }
              ],
              "external_urls": {
                "spotify": "https://open.spotify.com/album/2wXy2T8LTzttqivhNzAnsj"
              },
              "href": "https://api.spotify.com/v1/albums/2wXy2T8LTzttqivhNzAnsj",
              "id": "2wXy2T8LTzttqivhNzAnsj",
              "images": [
                {
                  "height": 640,
                  "url": "https://i.scdn.co/image/ab67616d0000b2737260810283e3d7ebb4f83f8d",
                  "width": 640
                },
                {
                  "height": 300,
                  "url": "https://i.scdn.co/image/ab67616d00001e027260810283e3d7ebb4f83f8d",
                  "width": 300
                },
                {
                  "height": 64,
                  "url": "https://i.scdn.co/image/ab67616d000048517260810283e3d7ebb4f83f8d",
                  "width": 64
                }
              ],
              "is_playable": true,
              "name": "Emotion Sickness",
              "release_date": "2019-10-11",
              "release_date_precision": "day",
              "total_tracks": 1,
              "type": "album",
              "uri": "spotify:album:2wXy2T8LTzttqivhNzAnsj"
            },
            "artists": [
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/2n7USVO8fO8FF8zq4kG2N1"
                },
                "href": "https://api.spotify.com/v1/artists/2n7USVO8fO8FF8zq4kG2N1",
                "id": "2n7USVO8fO8FF8zq4kG2N1",
                "name": "Mat Zo",
                "type": "artist",
                "uri": "spotify:artist:2n7USVO8fO8FF8zq4kG2N1"
              }
            ],
            "disc_number": 1,
            "duration_ms": 443720,
            "explicit": false,
            "external_ids": {
              "isrc": "CA5KR1958723"
            },
            "external_urls": {
              "spotify": "https://open.spotify.com/track/7Dfj4fyr6FMrXwDNas5A37"
            },
            "href": "https://api.spotify.com/v1/tracks/7Dfj4fyr6FMrXwDNas5A37",
            "id": "7Dfj4fyr6FMrXwDNas5A37",
            "is_local": false,
            "is_playable": true,
            "name": "Emotion Sickness",
            "popularity": 20,
            "preview_url": "https://p.scdn.co/mp3-preview/904767dab4f90e3d8b5c7d782486386f2eae1cc1?cid=0ad54630510047d288157ea602078764",
            "track_number": 1,
            "type": "track",
            "uri": "spotify:track:7Dfj4fyr6FMrXwDNas5A37"
          },
          {
            "album": {
              "album_type": "single",
              "artists": [
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/4pejUc4iciQfgdX6OKulQn"
                  },
                  "href": "https://api.spotify.com/v1/artists/4pejUc4iciQfgdX6OKulQn",
                  "id": "4pejUc4iciQfgdX6OKulQn",
                  "name": "Queens of the Stone Age",
                  "type": "artist",
                  "uri": "spotify:artist:4pejUc4iciQfgdX6OKulQn"
                }
              ],
              "external_urls": {
                "spotify": "https://open.spotify.com/album/2ec7VED8zxmb93zpjdFYBM"
              },
              "href": "https://api.spotify.com/v1/albums/2ec7VED8zxmb93zpjdFYBM",
              "id": "2ec7VED8zxmb93zpjdFYBM",
              "images": [
                {
                  "height": 640,
                  "url": "https://i.scdn.co/image/ab67616d0000b273df3b0e54d98071aa775b7f17",
                  "width": 640
                },
                {
                  "height": 300,
                  "url": "https://i.scdn.co/image/ab67616d00001e02df3b0e54d98071aa775b7f17",
                  "width": 300
                },
                {
                  "height": 64,
                  "url": "https://i.scdn.co/image/ab67616d00004851df3b0e54d98071aa775b7f17",
                  "width": 64
                }
              ],
              "is_playable": true,
              "name": "Paper Machete",
              "release_date": "2023-06-14",
              "release_date_precision": "day",
              "total_tracks": 3,
              "type": "album",
              "uri": "spotify:album:2ec7VED8zxmb93zpjdFYBM"
            },
            "artists": [
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/4pejUc4iciQfgdX6OKulQn"
                },
                "href": "https://api.spotify.com/v1/artists/4pejUc4iciQfgdX6OKulQn",
                "id": "4pejUc4iciQfgdX6OKulQn",
                "name": "Queens of the Stone Age",
                "type": "artist",
                "uri": "spotify:artist:4pejUc4iciQfgdX6OKulQn"
              }
            ],
            "disc_number": 1,
            "duration_ms": 271076,
            "explicit": true,
            "external_ids": {
              "isrc": "USMTD2200636"
            },
            "external_urls": {
              "spotify": "https://open.spotify.com/track/0XrDPymTPU2pPgXOZam9JR"
            },
            "href": "https://api.spotify.com/v1/tracks/0XrDPymTPU2pPgXOZam9JR",
            "id": "0XrDPymTPU2pPgXOZam9JR",
            "is_local": false,
            "is_playable": true,
            "name": "Emotion Sickness",
            "popularity": 28,
            "preview_url": "https://p.scdn.co/mp3-preview/93a8849b63d53633b6f4b0e8395af9d090a7885f?cid=0ad54630510047d288157ea602078764",
            "track_number": 3,
            "type": "track",
            "uri": "spotify:track:0XrDPymTPU2pPgXOZam9JR"
          },
          {
            "album": {
              "album_type": "album",
              "artists": [
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/1r1uxoy19fzMxunt3ONAkG"
                  },
                  "href": "https://api.spotify.com/v1/artists/1r1uxoy19fzMxunt3ONAkG",
                  "id": "1r1uxoy19fzMxunt3ONAkG",
                  "name": "Phoebe Bridgers",
                  "type": "artist",
                  "uri": "spotify:artist:1r1uxoy19fzMxunt3ONAkG"
                }
              ],
              "external_urls": {
                "spotify": "https://open.spotify.com/album/5rcJ5xCMYYLCgGilFDKRZl"
              },
              "href": "https://api.spotify.com/v1/albums/5rcJ5xCMYYLCgGilFDKRZl",
              "id": "5rcJ5xCMYYLCgGilFDKRZl",
              "images": [
                {
                  "height": 640,
                  "url": "https://i.scdn.co/image/ab67616d0000b27378d8e579122e4b9446954ee9",
                  "width": 640
                },
                {
                  "height": 300,
                  "url": "https://i.scdn.co/image/ab67616d00001e0278d8e579122e4b9446954ee9",
                  "width": 300
                },
                {
                  "height": 64,
                  "url": "https://i.scdn.co/image/ab67616d0000485178d8e579122e4b9446954ee9",
                  "width": 64
                }
              ],
              "is_playable": true,
              "name": "Stranger in the Alps (Deluxe Edition)",
              "release_date": "2018-10-02",
              "release_date_precision": "day",
              "total_tracks": 13,
              "type": "album",
              "uri": "spotify:album:5rcJ5xCMYYLCgGilFDKRZl"
            },
            "artists": [
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/1r1uxoy19fzMxunt3ONAkG"
                },
                "href": "https://api.spotify.com/v1/artists/1r1uxoy19fzMxunt3ONAkG",
                "id": "1r1uxoy19fzMxunt3ONAkG",
                "name": "Phoebe Bridgers",
                "type": "artist",
                "uri": "spotify:artist:1r1uxoy19fzMxunt3ONAkG"
              }
            ],
            "disc_number": 1,
            "duration_ms": 264452,
            "explicit": false,
            "external_ids": {
              "isrc": "USJ5G1714214"
            },
            "external_urls": {
              "spotify": "https://open.spotify.com/track/7xwyvVWewy01DhdgEt2WWq"
            },
            "href": "https://api.spotify.com/v1/tracks/7xwyvVWewy01DhdgEt2WWq",
            "id": "7xwyvVWewy01DhdgEt2WWq",
            "is_local": false,
            "is_playable": true,
            "name": "Motion Sickness (Demo - Bonus Track)",
            "popularity": 54,
            "preview_url": "https://p.scdn.co/mp3-preview/38233a3eaee21be65260e58038a3d47ba422d2d5?cid=0ad54630510047d288157ea602078764",
            "track_number": 13,
            "type": "track",
            "uri": "spotify:track:7xwyvVWewy01DhdgEt2WWq"
          },
          {
            "album": {
              "album_type": "album",
              "artists": [
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/3VgeHNeAuBFBvRkQwYyS4f"
                  },
                  "href": "https://api.spotify.com/v1/artists/3VgeHNeAuBFBvRkQwYyS4f",
                  "id": "3VgeHNeAuBFBvRkQwYyS4f",
                  "name": "FiFi",
                  "type": "artist",
                  "uri": "spotify:artist:3VgeHNeAuBFBvRkQwYyS4f"
                }
              ],
              "external_urls": {
                "spotify": "https://open.spotify.com/album/5o5VDOoduOLNzVFW6GehTV"
              },
              "href": "https://api.spotify.com/v1/albums/5o5VDOoduOLNzVFW6GehTV",
              "id": "5o5VDOoduOLNzVFW6GehTV",
              "images": [
                {
                  "height": 640,
                  "url": "https://i.scdn.co/image/ab67616d0000b273a52e1f1de41ac74e1f29d0ae",
                  "width": 640
                },
                {
                  "height": 300,
                  "url": "https://i.scdn.co/image/ab67616d00001e02a52e1f1de41ac74e1f29d0ae",
                  "width": 300
                },
                {
                  "height": 64,
                  "url": "https://i.scdn.co/image/ab67616d00004851a52e1f1de41ac74e1f29d0ae",
                  "width": 64
                }
              ],
              "is_playable": true,
              "name": "Sink Hole",
              "release_date": "1997-01-13",
              "release_date_precision": "day",
              "total_tracks": 16,
              "type": "album",
              "uri": "spotify:album:5o5VDOoduOLNzVFW6GehTV"
            },
            "artists": [
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/3VgeHNeAuBFBvRkQwYyS4f"
                },
                "href": "https://api.spotify.com/v1/artists/3VgeHNeAuBFBvRkQwYyS4f",
                "id": "3VgeHNeAuBFBvRkQwYyS4f",
                "name": "FiFi",
                "type": "artist",
                "uri": "spotify:artist:3VgeHNeAuBFBvRkQwYyS4f"
              }
            ],
            "disc_number": 1,
            "duration_ms": 178026,
            "explicit": true,
            "external_ids": {
              "isrc": "QZFZ22276483"
            },
            "external_urls": {
              "spotify": "https://open.spotify.com/track/336rKr2n2ZL0O6zXfDyUEx"
            },
            "href": "https://api.spotify.com/v1/tracks/336rKr2n2ZL0O6zXfDyUEx",
            "id": "336rKr2n2ZL0O6zXfDyUEx",
            "is_local": false,
            "is_playable": true,
            "name": "Emotion Sickness",
            "popularity": 1,
            "preview_url": "https://p.scdn.co/mp3-preview/c4ebad77ebd3dbe9de89875093b2664ac716f389?cid=0ad54630510047d288157ea602078764",
            "track_number": 15,
            "type": "track",
            "uri": "spotify:track:336rKr2n2ZL0O6zXfDyUEx"
          },
          {
            "album": {
              "album_type": "single",
              "artists": [
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/47XUgyBFio7hvip5t6kryc"
                  },
                  "href": "https://api.spotify.com/v1/artists/47XUgyBFio7hvip5t6kryc",
                  "id": "47XUgyBFio7hvip5t6kryc",
                  "name": "Dayne Kajewski",
                  "type": "artist",
                  "uri": "spotify:artist:47XUgyBFio7hvip5t6kryc"
                }
              ],
              "external_urls": {
                "spotify": "https://open.spotify.com/album/5WYzVn8aeB50kh49NJARc4"
              },
              "href": "https://api.spotify.com/v1/albums/5WYzVn8aeB50kh49NJARc4",
              "id": "5WYzVn8aeB50kh49NJARc4",
              "images": [
                {
                  "height": 640,
                  "url": "https://i.scdn.co/image/ab67616d0000b273a2552bd63f0d675e09f9f32b",
                  "width": 640
                },
                {
                  "height": 300,
                  "url": "https://i.scdn.co/image/ab67616d00001e02a2552bd63f0d675e09f9f32b",
                  "width": 300
                },
                {
                  "height": 64,
                  "url": "https://i.scdn.co/image/ab67616d00004851a2552bd63f0d675e09f9f32b",
                  "width": 64
                }
              ],
              "is_playable": true,
              "name": "Emotion Sickness",
              "release_date": "2023-10-13",
              "release_date_precision": "day",
              "total_tracks": 1,
              "type": "album",
              "uri": "spotify:album:5WYzVn8aeB50kh49NJARc4"
            },
            "artists": [
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/47XUgyBFio7hvip5t6kryc"
                },
                "href": "https://api.spotify.com/v1/artists/47XUgyBFio7hvip5t6kryc",
                "id": "47XUgyBFio7hvip5t6kryc",
                "name": "Dayne Kajewski",
                "type": "artist",
                "uri": "spotify:artist:47XUgyBFio7hvip5t6kryc"
              }
            ],
            "disc_number": 1,
            "duration_ms": 175775,
            "explicit": true,
            "external_ids": {
              "isrc": "USL4Q2370999"
            },
            "external_urls": {
              "spotify": "https://open.spotify.com/track/6GzmohkaLOuv73jm7meq4M"
            },
            "href": "https://api.spotify.com/v1/tracks/6GzmohkaLOuv73jm7meq4M",
            "id": "6GzmohkaLOuv73jm7meq4M",
            "is_local": false,
            "is_playable": true,
            "name": "Emotion Sickness",
            "popularity": 1,
            "preview_url": "https://p.scdn.co/mp3-preview/ab12dbe3683963eb8c22c5969d9843db02a53052?cid=0ad54630510047d288157ea602078764",
            "track_number": 1,
            "type": "track",
            "uri": "spotify:track:6GzmohkaLOuv73jm7meq4M"
          },
          {
            "album": {
              "album_type": "single",
              "artists": [
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/4LZ4De2MoO3lP6QaNCfvcu"
                  },
                  "href": "https://api.spotify.com/v1/artists/4LZ4De2MoO3lP6QaNCfvcu",
                  "id": "4LZ4De2MoO3lP6QaNCfvcu",
                  "name": "Said The Sky",
                  "type": "artist",
                  "uri": "spotify:artist:4LZ4De2MoO3lP6QaNCfvcu"
                },
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/3jASw3YQHarl90fZWNyCdn"
                  },
                  "href": "https://api.spotify.com/v1/artists/3jASw3YQHarl90fZWNyCdn",
                  "id": "3jASw3YQHarl90fZWNyCdn",
                  "name": "Will Anderson",
                  "type": "artist",
                  "uri": "spotify:artist:3jASw3YQHarl90fZWNyCdn"
                },
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/2PCUhxD40qlMqsKHjTZD2e"
                  },
                  "href": "https://api.spotify.com/v1/artists/2PCUhxD40qlMqsKHjTZD2e",
                  "id": "2PCUhxD40qlMqsKHjTZD2e",
                  "name": "Parachute",
                  "type": "artist",
                  "uri": "spotify:artist:2PCUhxD40qlMqsKHjTZD2e"
                }
              ],
              "external_urls": {
                "spotify": "https://open.spotify.com/album/1MFT48MAeFGewEj3jzaBU2"
              },
              "href": "https://api.spotify.com/v1/albums/1MFT48MAeFGewEj3jzaBU2",
              "id": "1MFT48MAeFGewEj3jzaBU2",
              "images": [
                {
                  "height": 640,
                  "url": "https://i.scdn.co/image/ab67616d0000b2733660cd70492ba857f466e43f",
                  "width": 640
                },
                {
                  "height": 300,
                  "url": "https://i.scdn.co/image/ab67616d00001e023660cd70492ba857f466e43f",
                  "width": 300
                },
                {
                  "height": 64,
                  "url": "https://i.scdn.co/image/ab67616d000048513660cd70492ba857f466e43f",
                  "width": 64
                }
              ],
              "is_playable": true,
              "name": "Emotion Sickness",
              "release_date": "2022-02-16",
              "release_date_precision": "day",
              "total_tracks": 1,
              "type": "album",
              "uri": "spotify:album:1MFT48MAeFGewEj3jzaBU2"
            },
            "artists": [
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/2PCUhxD40qlMqsKHjTZD2e"
                },
                "href": "https://api.spotify.com/v1/artists/2PCUhxD40qlMqsKHjTZD2e",
                "id": "2PCUhxD40qlMqsKHjTZD2e",
                "name": "Parachute",
                "type": "artist",
                "uri": "spotify:artist:2PCUhxD40qlMqsKHjTZD2e"
              },
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/4LZ4De2MoO3lP6QaNCfvcu"
                },
                "href": "https://api.spotify.com/v1/artists/4LZ4De2MoO3lP6QaNCfvcu",
                "id": "4LZ4De2MoO3lP6QaNCfvcu",
                "name": "Said The Sky",
                "type": "artist",
                "uri": "spotify:artist:4LZ4De2MoO3lP6QaNCfvcu"
              },
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/3jASw3YQHarl90fZWNyCdn"
                },
                "href": "https://api.spotify.com/v1/artists/3jASw3YQHarl90fZWNyCdn",
                "id": "3jASw3YQHarl90fZWNyCdn",
                "name": "Will Anderson",
                "type": "artist",
                "uri": "spotify:artist:3jASw3YQHarl90fZWNyCdn"
              }
            ],
            "disc_number": 1,
            "duration_ms": 202493,
            "explicit": false,
            "external_ids": {
              "isrc": "GBKPL2282216"
            },
            "external_urls": {
              "spotify": "https://open.spotify.com/track/1fT1qqkJxKL5Lfi5HOlZua"
            },
            "href": "https://api.spotify.com/v1/tracks/1fT1qqkJxKL5Lfi5HOlZua",
            "id": "1fT1qqkJxKL5Lfi5HOlZua",
            "is_local": false,
            "is_playable": true,
            "name": "Emotion Sickness",
            "popularity": 20,
            "preview_url": "https://p.scdn.co/mp3-preview/d5b92647bf5c1f2ed868313bcc8e4aa3e862a2de?cid=0ad54630510047d288157ea602078764",
            "track_number": 1,
            "type": "track",
            "uri": "spotify:track:1fT1qqkJxKL5Lfi5HOlZua"
          },
          {
            "album": {
              "album_type": "album",
              "artists": [
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/4LZ4De2MoO3lP6QaNCfvcu"
                  },
                  "href": "https://api.spotify.com/v1/artists/4LZ4De2MoO3lP6QaNCfvcu",
                  "id": "4LZ4De2MoO3lP6QaNCfvcu",
                  "name": "Said The Sky",
                  "type": "artist",
                  "uri": "spotify:artist:4LZ4De2MoO3lP6QaNCfvcu"
                }
              ],
              "external_urls": {
                "spotify": "https://open.spotify.com/album/50LvtJUOXQqb4EVM2mij0V"
              },
              "href": "https://api.spotify.com/v1/albums/50LvtJUOXQqb4EVM2mij0V",
              "id": "50LvtJUOXQqb4EVM2mij0V",
              "images": [
                {
                  "height": 640,
                  "url": "https://i.scdn.co/image/ab67616d0000b2739a7ffcb5154d11fe92c8cfc2",
                  "width": 640
                },
                {
                  "height": 300,
                  "url": "https://i.scdn.co/image/ab67616d00001e029a7ffcb5154d11fe92c8cfc2",
                  "width": 300
                },
                {
                  "height": 64,
                  "url": "https://i.scdn.co/image/ab67616d000048519a7ffcb5154d11fe92c8cfc2",
                  "width": 64
                }
              ],
              "is_playable": true,
              "name": "Sentiment (The Remixes)",
              "release_date": "2022-07-29",
              "release_date_precision": "day",
              "total_tracks": 22,
              "type": "album",
              "uri": "spotify:album:50LvtJUOXQqb4EVM2mij0V"
            },
            "artists": [
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/4LZ4De2MoO3lP6QaNCfvcu"
                },
                "href": "https://api.spotify.com/v1/artists/4LZ4De2MoO3lP6QaNCfvcu",
                "id": "4LZ4De2MoO3lP6QaNCfvcu",
                "name": "Said The Sky",
                "type": "artist",
                "uri": "spotify:artist:4LZ4De2MoO3lP6QaNCfvcu"
              },
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/3jASw3YQHarl90fZWNyCdn"
                },
                "href": "https://api.spotify.com/v1/artists/3jASw3YQHarl90fZWNyCdn",
                "id": "3jASw3YQHarl90fZWNyCdn",
                "name": "Will Anderson",
                "type": "artist",
                "uri": "spotify:artist:3jASw3YQHarl90fZWNyCdn"
              },
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/2PCUhxD40qlMqsKHjTZD2e"
                },
                "href": "https://api.spotify.com/v1/artists/2PCUhxD40qlMqsKHjTZD2e",
                "id": "2PCUhxD40qlMqsKHjTZD2e",
                "name": "Parachute",
                "type": "artist",
                "uri": "spotify:artist:2PCUhxD40qlMqsKHjTZD2e"
              },
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/6AEtbUZpqqqGtkOwRZxSRc"
                },
                "href": "https://api.spotify.com/v1/artists/6AEtbUZpqqqGtkOwRZxSRc",
                "id": "6AEtbUZpqqqGtkOwRZxSRc",
                "name": "Dust of Apollon",
                "type": "artist",
                "uri": "spotify:artist:6AEtbUZpqqqGtkOwRZxSRc"
              }
            ],
            "disc_number": 1,
            "duration_ms": 208571,
            "explicit": false,
            "external_ids": {
              "isrc": "CA5KR2259315"
            },
            "external_urls": {
              "spotify": "https://open.spotify.com/track/7rHSIDUCz341nJqBIuYVCx"
            },
            "href": "https://api.spotify.com/v1/tracks/7rHSIDUCz341nJqBIuYVCx",
            "id": "7rHSIDUCz341nJqBIuYVCx",
            "is_local": false,
            "is_playable": true,
            "name": "Emotion Sickness - Dust of Apollon Remix",
            "popularity": 21,
            "preview_url": "https://p.scdn.co/mp3-preview/b26c0ed8a5304bd1975d7fa88840907282f5610e?cid=0ad54630510047d288157ea602078764",
            "track_number": 9,
            "type": "track",
            "uri": "spotify:track:7rHSIDUCz341nJqBIuYVCx"
          },
          {
            "album": {
              "album_type": "album",
              "artists": [
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/4LZ4De2MoO3lP6QaNCfvcu"
                  },
                  "href": "https://api.spotify.com/v1/artists/4LZ4De2MoO3lP6QaNCfvcu",
                  "id": "4LZ4De2MoO3lP6QaNCfvcu",
                  "name": "Said The Sky",
                  "type": "artist",
                  "uri": "spotify:artist:4LZ4De2MoO3lP6QaNCfvcu"
                }
              ],
              "external_urls": {
                "spotify": "https://open.spotify.com/album/50LvtJUOXQqb4EVM2mij0V"
              },
              "href": "https://api.spotify.com/v1/albums/50LvtJUOXQqb4EVM2mij0V",
              "id": "50LvtJUOXQqb4EVM2mij0V",
              "images": [
                {
                  "height": 640,
                  "url": "https://i.scdn.co/image/ab67616d0000b2739a7ffcb5154d11fe92c8cfc2",
                  "width": 640
                },
                {
                  "height": 300,
                  "url": "https://i.scdn.co/image/ab67616d00001e029a7ffcb5154d11fe92c8cfc2",
                  "width": 300
                },
                {
                  "height": 64,
                  "url": "https://i.scdn.co/image/ab67616d000048519a7ffcb5154d11fe92c8cfc2",
                  "width": 64
                }
              ],
              "is_playable": true,
              "name": "Sentiment (The Remixes)",
              "release_date": "2022-07-29",
              "release_date_precision": "day",
              "total_tracks": 22,
              "type": "album",
              "uri": "spotify:album:50LvtJUOXQqb4EVM2mij0V"
            },
            "artists": [
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/4LZ4De2MoO3lP6QaNCfvcu"
                },
                "href": "https://api.spotify.com/v1/artists/4LZ4De2MoO3lP6QaNCfvcu",
                "id": "4LZ4De2MoO3lP6QaNCfvcu",
                "name": "Said The Sky",
                "type": "artist",
                "uri": "spotify:artist:4LZ4De2MoO3lP6QaNCfvcu"
              },
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/3jASw3YQHarl90fZWNyCdn"
                },
                "href": "https://api.spotify.com/v1/artists/3jASw3YQHarl90fZWNyCdn",
                "id": "3jASw3YQHarl90fZWNyCdn",
                "name": "Will Anderson",
                "type": "artist",
                "uri": "spotify:artist:3jASw3YQHarl90fZWNyCdn"
              },
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/2PCUhxD40qlMqsKHjTZD2e"
                },
                "href": "https://api.spotify.com/v1/artists/2PCUhxD40qlMqsKHjTZD2e",
                "id": "2PCUhxD40qlMqsKHjTZD2e",
                "name": "Parachute",
                "type": "artist",
                "uri": "spotify:artist:2PCUhxD40qlMqsKHjTZD2e"
              },
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/0dVEujdtPApE4xAi0lx1FN"
                },
                "href": "https://api.spotify.com/v1/artists/0dVEujdtPApE4xAi0lx1FN",
                "id": "0dVEujdtPApE4xAi0lx1FN",
                "name": "Malva.",
                "type": "artist",
                "uri": "spotify:artist:0dVEujdtPApE4xAi0lx1FN"
              }
            ],
            "disc_number": 1,
            "duration_ms": 205714,
            "explicit": false,
            "external_ids": {
              "isrc": "CA5KR2259304"
            },
            "external_urls": {
              "spotify": "https://open.spotify.com/track/7yNX3UMymJzLfSSqx2qN28"
            },
            "href": "https://api.spotify.com/v1/tracks/7yNX3UMymJzLfSSqx2qN28",
            "id": "7yNX3UMymJzLfSSqx2qN28",
            "is_local": false,
            "is_playable": true,
            "name": "Emotion Sickness - Malva. Remix",
            "popularity": 21,
            "preview_url": "https://p.scdn.co/mp3-preview/a1e0bc8307255f3b3213791ec8a7bbe7108bb8f7?cid=0ad54630510047d288157ea602078764",
            "track_number": 10,
            "type": "track",
            "uri": "spotify:track:7yNX3UMymJzLfSSqx2qN28"
          },
          {
            "album": {
              "album_type": "album",
              "artists": [
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/0mzTssRDPIQVH5wSNzOdFZ"
                  },
                  "href": "https://api.spotify.com/v1/artists/0mzTssRDPIQVH5wSNzOdFZ",
                  "id": "0mzTssRDPIQVH5wSNzOdFZ",
                  "name": "Fefe Dobson",
                  "type": "artist",
                  "uri": "spotify:artist:0mzTssRDPIQVH5wSNzOdFZ"
                }
              ],
              "external_urls": {
                "spotify": "https://open.spotify.com/album/7qpJHu4q1taE6JOFvdm6YA"
              },
              "href": "https://api.spotify.com/v1/albums/7qpJHu4q1taE6JOFvdm6YA",
              "id": "7qpJHu4q1taE6JOFvdm6YA",
              "images": [
                {
                  "height": 640,
                  "url": "https://i.scdn.co/image/ab67616d0000b2733994662ce5c5978d75beb4c8",
                  "width": 640
                },
                {
                  "height": 300,
                  "url": "https://i.scdn.co/image/ab67616d00001e023994662ce5c5978d75beb4c8",
                  "width": 300
                },
                {
                  "height": 64,
                  "url": "https://i.scdn.co/image/ab67616d000048513994662ce5c5978d75beb4c8",
                  "width": 64
                }
              ],
              "is_playable": true,
              "name": "EMOTION SICKNESS",
              "release_date": "2023-09-29",
              "release_date_precision": "day",
              "total_tracks": 9,
              "type": "album",
              "uri": "spotify:album:7qpJHu4q1taE6JOFvdm6YA"
            },
            "artists": [
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/0mzTssRDPIQVH5wSNzOdFZ"
                },
                "href": "https://api.spotify.com/v1/artists/0mzTssRDPIQVH5wSNzOdFZ",
                "id": "0mzTssRDPIQVH5wSNzOdFZ",
                "name": "Fefe Dobson",
                "type": "artist",
                "uri": "spotify:artist:0mzTssRDPIQVH5wSNzOdFZ"
              }
            ],
            "disc_number": 1,
            "duration_ms": 163760,
            "explicit": false,
            "external_ids": {
              "isrc": "USJ442300027"
            },
            "external_urls": {
              "spotify": "https://open.spotify.com/track/69XM2hnoX1hVwqDGnnGZSq"
            },
            "href": "https://api.spotify.com/v1/tracks/69XM2hnoX1hVwqDGnnGZSq",
            "id": "69XM2hnoX1hVwqDGnnGZSq",
            "is_local": false,
            "is_playable": true,
            "name": "SHUT UP AND KISS ME",
            "popularity": 43,
            "preview_url": "https://p.scdn.co/mp3-preview/8cd291e9aa1b2aa6283ebacd54b9ff727aa002d1?cid=0ad54630510047d288157ea602078764",
            "track_number": 3,
            "type": "track",
            "uri": "spotify:track:69XM2hnoX1hVwqDGnnGZSq"
          },
          {
            "album": {
              "album_type": "album",
              "artists": [
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/00IiVt687EdR9JnSoJN7IA"
                  },
                  "href": "https://api.spotify.com/v1/artists/00IiVt687EdR9JnSoJN7IA",
                  "id": "00IiVt687EdR9JnSoJN7IA",
                  "name": "Mazza_l20",
                  "type": "artist",
                  "uri": "spotify:artist:00IiVt687EdR9JnSoJN7IA"
                }
              ],
              "external_urls": {
                "spotify": "https://open.spotify.com/album/5ZCSGeltEmsrr9zWuHv2Fs"
              },
              "href": "https://api.spotify.com/v1/albums/5ZCSGeltEmsrr9zWuHv2Fs",
              "id": "5ZCSGeltEmsrr9zWuHv2Fs",
              "images": [
                {
                  "height": 640,
                  "url": "https://i.scdn.co/image/ab67616d0000b273686efa27468c5b6757d1f36f",
                  "width": 640
                },
                {
                  "height": 300,
                  "url": "https://i.scdn.co/image/ab67616d00001e02686efa27468c5b6757d1f36f",
                  "width": 300
                },
                {
                  "height": 64,
                  "url": "https://i.scdn.co/image/ab67616d00004851686efa27468c5b6757d1f36f",
                  "width": 64
                }
              ],
              "is_playable": true,
              "name": "Concrete Jungle",
              "release_date": "2023-08-29",
              "release_date_precision": "day",
              "total_tracks": 12,
              "type": "album",
              "uri": "spotify:album:5ZCSGeltEmsrr9zWuHv2Fs"
            },
            "artists": [
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/00IiVt687EdR9JnSoJN7IA"
                },
                "href": "https://api.spotify.com/v1/artists/00IiVt687EdR9JnSoJN7IA",
                "id": "00IiVt687EdR9JnSoJN7IA",
                "name": "Mazza_l20",
                "type": "artist",
                "uri": "spotify:artist:00IiVt687EdR9JnSoJN7IA"
              }
            ],
            "disc_number": 1,
            "duration_ms": 224680,
            "explicit": true,
            "external_ids": {
              "isrc": "QZNWS2378569"
            },
            "external_urls": {
              "spotify": "https://open.spotify.com/track/4yr9gSPRZwH1G7EhrjQ6QN"
            },
            "href": "https://api.spotify.com/v1/tracks/4yr9gSPRZwH1G7EhrjQ6QN",
            "id": "4yr9gSPRZwH1G7EhrjQ6QN",
            "is_local": false,
            "is_playable": true,
            "name": "Emotional Scars",
            "popularity": 47,
            "preview_url": "https://p.scdn.co/mp3-preview/84c4abbde5e5669a7049c45c2cd3ab5cc990ac42?cid=0ad54630510047d288157ea602078764",
            "track_number": 2,
            "type": "track",
            "uri": "spotify:track:4yr9gSPRZwH1G7EhrjQ6QN"
          },
          {
            "album": {
              "album_type": "album",
              "artists": [
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/1N2TLObIcdbgEG8LQrvEeu"
                  },
                  "href": "https://api.spotify.com/v1/artists/1N2TLObIcdbgEG8LQrvEeu",
                  "id": "1N2TLObIcdbgEG8LQrvEeu",
                  "name": "Rashaka Malik",
                  "type": "artist",
                  "uri": "spotify:artist:1N2TLObIcdbgEG8LQrvEeu"
                }
              ],
              "external_urls": {
                "spotify": "https://open.spotify.com/album/4vuACh2k3iI7S3OL7KFDgx"
              },
              "href": "https://api.spotify.com/v1/albums/4vuACh2k3iI7S3OL7KFDgx",
              "id": "4vuACh2k3iI7S3OL7KFDgx",
              "images": [
                {
                  "height": 640,
                  "url": "https://i.scdn.co/image/ab67616d0000b273ba6d8b1a9d4e129343a24b09",
                  "width": 640
                },
                {
                  "height": 300,
                  "url": "https://i.scdn.co/image/ab67616d00001e02ba6d8b1a9d4e129343a24b09",
                  "width": 300
                },
                {
                  "height": 64,
                  "url": "https://i.scdn.co/image/ab67616d00004851ba6d8b1a9d4e129343a24b09",
                  "width": 64
                }
              ],
              "is_playable": true,
              "name": "Release",
              "release_date": "2023-10-11",
              "release_date_precision": "day",
              "total_tracks": 8,
              "type": "album",
              "uri": "spotify:album:4vuACh2k3iI7S3OL7KFDgx"
            },
            "artists": [
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/1N2TLObIcdbgEG8LQrvEeu"
                },
                "href": "https://api.spotify.com/v1/artists/1N2TLObIcdbgEG8LQrvEeu",
                "id": "1N2TLObIcdbgEG8LQrvEeu",
                "name": "Rashaka Malik",
                "type": "artist",
                "uri": "spotify:artist:1N2TLObIcdbgEG8LQrvEeu"
              }
            ],
            "disc_number": 1,
            "duration_ms": 118857,
            "explicit": false,
            "external_ids": {
              "isrc": "AUBEC2347175"
            },
            "external_urls": {
              "spotify": "https://open.spotify.com/track/46ZMUJqd8FSgYTz9wNLLTv"
            },
            "href": "https://api.spotify.com/v1/tracks/46ZMUJqd8FSgYTz9wNLLTv",
            "id": "46ZMUJqd8FSgYTz9wNLLTv",
            "is_local": false,
            "is_playable": true,
            "name": "Emotional",
            "popularity": 15,
            "preview_url": "https://p.scdn.co/mp3-preview/64c8b76a649230188b8c25ef7f8eaad0e32774b4?cid=0ad54630510047d288157ea602078764",
            "track_number": 3,
            "type": "track",
            "uri": "spotify:track:46ZMUJqd8FSgYTz9wNLLTv"
          },
          {
            "album": {
              "album_type": "album",
              "artists": [
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/63X1WKthLQidtqxxO2sgeq"
                  },
                  "href": "https://api.spotify.com/v1/artists/63X1WKthLQidtqxxO2sgeq",
                  "id": "63X1WKthLQidtqxxO2sgeq",
                  "name": "MIST",
                  "type": "artist",
                  "uri": "spotify:artist:63X1WKthLQidtqxxO2sgeq"
                }
              ],
              "external_urls": {
                "spotify": "https://open.spotify.com/album/0HwtpGFu6ry55lObcu8McB"
              },
              "href": "https://api.spotify.com/v1/albums/0HwtpGFu6ry55lObcu8McB",
              "id": "0HwtpGFu6ry55lObcu8McB",
              "images": [
                {
                  "height": 640,
                  "url": "https://i.scdn.co/image/ab67616d0000b273d9e5474fcd64464b8ad1b044",
                  "width": 640
                },
                {
                  "height": 300,
                  "url": "https://i.scdn.co/image/ab67616d00001e02d9e5474fcd64464b8ad1b044",
                  "width": 300
                },
                {
                  "height": 64,
                  "url": "https://i.scdn.co/image/ab67616d00004851d9e5474fcd64464b8ad1b044",
                  "width": 64
                }
              ],
              "is_playable": true,
              "name": "Redemption",
              "release_date": "2023-10-13",
              "release_date_precision": "day",
              "total_tracks": 12,
              "type": "album",
              "uri": "spotify:album:0HwtpGFu6ry55lObcu8McB"
            },
            "artists": [
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/63X1WKthLQidtqxxO2sgeq"
                },
                "href": "https://api.spotify.com/v1/artists/63X1WKthLQidtqxxO2sgeq",
                "id": "63X1WKthLQidtqxxO2sgeq",
                "name": "MIST",
                "type": "artist",
                "uri": "spotify:artist:63X1WKthLQidtqxxO2sgeq"
              },
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/0T2sGLJKge2eaFmZJxX7sq"
                },
                "href": "https://api.spotify.com/v1/artists/0T2sGLJKge2eaFmZJxX7sq",
                "id": "0T2sGLJKge2eaFmZJxX7sq",
                "name": "Wretch 32",
                "type": "artist",
                "uri": "spotify:artist:0T2sGLJKge2eaFmZJxX7sq"
              }
            ],
            "disc_number": 1,
            "duration_ms": 163692,
            "explicit": true,
            "external_ids": {
              "isrc": "GBAHT2300726"
            },
            "external_urls": {
              "spotify": "https://open.spotify.com/track/54EkC6X0p4kc6KTDhqROnd"
            },
            "href": "https://api.spotify.com/v1/tracks/54EkC6X0p4kc6KTDhqROnd",
            "id": "54EkC6X0p4kc6KTDhqROnd",
            "is_local": false,
            "is_playable": true,
            "name": "Emotional (feat. Wretch 32)",
            "popularity": 45,
            "preview_url": "https://p.scdn.co/mp3-preview/57055766bc09edd7cee3d480268002c63384874b?cid=0ad54630510047d288157ea602078764",
            "track_number": 12,
            "type": "track",
            "uri": "spotify:track:54EkC6X0p4kc6KTDhqROnd"
          },
          {
            "album": {
              "album_type": "album",
              "artists": [
                {
                  "external_urls": {
                    "spotify": "https://open.spotify.com/artist/5cl94KH31a5IZzJdaXJJ9X"
                  },
                  "href": "https://api.spotify.com/v1/artists/5cl94KH31a5IZzJdaXJJ9X",
                  "id": "5cl94KH31a5IZzJdaXJJ9X",
                  "name": "Giles Middleton",
                  "type": "artist",
                  "uri": "spotify:artist:5cl94KH31a5IZzJdaXJJ9X"
                }
              ],
              "external_urls": {
                "spotify": "https://open.spotify.com/album/76NI0FwWT8DWTS9yStmVvh"
              },
              "href": "https://api.spotify.com/v1/albums/76NI0FwWT8DWTS9yStmVvh",
              "id": "76NI0FwWT8DWTS9yStmVvh",
              "images": [
                {
                  "height": 640,
                  "url": "https://i.scdn.co/image/ab67616d0000b2733566ff9a80354f615d23a785",
                  "width": 640
                },
                {
                  "height": 300,
                  "url": "https://i.scdn.co/image/ab67616d00001e023566ff9a80354f615d23a785",
                  "width": 300
                },
                {
                  "height": 64,
                  "url": "https://i.scdn.co/image/ab67616d000048513566ff9a80354f615d23a785",
                  "width": 64
                }
              ],
              "is_playable": true,
              "name": "I The Block",
              "release_date": "2023-09-05",
              "release_date_precision": "day",
              "total_tracks": 12,
              "type": "album",
              "uri": "spotify:album:76NI0FwWT8DWTS9yStmVvh"
            },
            "artists": [
              {
                "external_urls": {
                  "spotify": "https://open.spotify.com/artist/5cl94KH31a5IZzJdaXJJ9X"
                },
                "href": "https://api.spotify.com/v1/artists/5cl94KH31a5IZzJdaXJJ9X",
                "id": "5cl94KH31a5IZzJdaXJJ9X",
                "name": "Giles Middleton",
                "type": "artist",
                "uri": "spotify:artist:5cl94KH31a5IZzJdaXJJ9X"
              }
            ],
            "disc_number": 1,
            "duration_ms": 166733,
            "explicit": true,
            "external_ids": {
              "isrc": "QZS652312323"
            },
            "external_urls": {
              "spotify": "https://open.spotify.com/track/2m0v5UsAhhJNjSFGwKYNDF"
            },
            "href": "https://api.spotify.com/v1/tracks/2m0v5UsAhhJNjSFGwKYNDF",
            "id": "2m0v5UsAhhJNjSFGwKYNDF",
            "is_local": false,
            "is_playable": true,
            "name": "Emotional Response",
            "popularity": 20,
            "preview_url": "https://p.scdn.co/mp3-preview/c3fdad7e7e331f2e03ef09fec1d2a3aab46a9556?cid=0ad54630510047d288157ea602078764",
            "track_number": 1,
            "type": "track",
            "uri": "spotify:track:2m0v5UsAhhJNjSFGwKYNDF"
          }
        ],
        "limit": 20,
        "next": "https://api.spotify.com/v1/search?query=emotion+sickness&type=track&market=IE&locale=en-GB%2Cen%3Bq%3D0.9&offset=20&limit=20",
        "offset": 0,
        "previous": null,
        "total": 1000
      }
    }
    """
    
    private let audioAnalysisResponseString: String = """
    {
      "meta": {
        "analyzer_version": "4.0.0",
        "platform": "Linux",
        "detailed_status": "OK",
        "status_code": 0,
        "timestamp": 1495193577,
        "analysis_time": 6.93906,
        "input_process": "libvorbisfile L+R 44100->22050"
      },
      "track": {
        "num_samples": 4585515,
        "duration": 207.95985,
        "sample_md5": "string",
        "offset_seconds": 0,
        "window_seconds": 0,
        "analysis_sample_rate": 22050,
        "analysis_channels": 1,
        "end_of_fade_in": 0,
        "start_of_fade_out": 201.13705,
        "loudness": -5.883,
        "tempo": 118.211,
        "tempo_confidence": 0.73,
        "time_signature": 4,
        "time_signature_confidence": 0.994,
        "key": 9,
        "key_confidence": 0.408,
        "mode": 0,
        "mode_confidence": 0.485,
        "codestring": "string",
        "code_version": 3.15,
        "echoprintstring": "string",
        "echoprint_version": 4.15,
        "synchstring": "string",
        "synch_version": 1,
        "rhythmstring": "string",
        "rhythm_version": 1
      },
      "bars": [
        {
          "start": 0.49567,
          "duration": 2.18749,
          "confidence": 0.925
        }
      ],
      "beats": [
        {
          "start": 0.49567,
          "duration": 2.18749,
          "confidence": 0.925
        }
      ],
      "sections": [
        {
          "start": 0,
          "duration": 6.97092,
          "confidence": 1,
          "loudness": -14.938,
          "tempo": 113.178,
          "tempo_confidence": 0.647,
          "key": 9,
          "key_confidence": 0.297,
          "mode": -1,
          "mode_confidence": 0.471,
          "time_signature": 4,
          "time_signature_confidence": 1
        }
      ],
      "segments": [
        {
          "start": 0.70154,
          "duration": 0.19891,
          "confidence": 0.435,
          "loudness_start": -23.053,
          "loudness_max": -14.25,
          "loudness_max_time": 0.07305,
          "loudness_end": 0,
          "pitches": [
            0.212,
            0.141,
            0.294
          ],
          "timbre": [
            42.115,
            64.373,
            -0.233
          ]
        }
      ],
      "tatums": [
        {
          "start": 0.49567,
          "duration": 2.18749,
          "confidence": 0.925
        }
      ]
    }
    """
}
