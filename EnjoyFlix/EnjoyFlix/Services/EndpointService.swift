//
//  EndpointService.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 18.07.2023.
//

import Foundation


struct EndpointService {
    struct Movies {
        static func nowPlaying(atPage page: Int) -> URL? {
            URL(string: "\(baseURL)/3/movie/now_playing?api_key=\(apiKey)&language=en-US&page=\(page)")
        }
        static func upcoming(atPage page: Int) -> URL? {
            URL(string: "\(baseURL)/3/movie/upcoming?api_key=\(apiKey)&language=en-US&page=\(page)")
        }

        static func topRated(atPage page: Int) -> URL? {
            URL(string: "\(baseURL)/3/movie/top_rated?api_key=\(apiKey)&language=en-US&page=\(page)")
        }

        static func popular(atPage page: Int) -> URL? {
            URL(string: "\(baseURL)/3/movie/popular?api_key=\(apiKey)&language=en-US&page=\(page)")
        }

        static func poster(ofMovie posterId: String) -> URL? {
            URL(string: "\(mediaBaseURL)\(posterId)")
        }
    }
}


fileprivate let baseURL = "https://api.themoviedb.org"
fileprivate let mediaBaseURL = "https://image.tmdb.org/t/p/original"
fileprivate let apiKey = "c51c01d6b237900097f895fb7fd09ed4"
