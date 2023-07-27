//
//  Response.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 18.07.2023.
//

import Foundation


protocol HTTPResponse: Decodable {}

struct MoviesListResponse: HTTPResponse {
    let page: Int
    let results: [MovieResponse]
}


struct MovieResponse: HTTPResponse{
    let id: Int
    let title: String
    let posterPath: String
    let releaseDate: Date
}

struct SeriesListResponse: HTTPResponse{
    let page: Int
    let results: [SeriesResponse]
}


struct SeriesResponse: HTTPResponse{
    let id: Int
    let name: String
    let posterPath: String?
}

