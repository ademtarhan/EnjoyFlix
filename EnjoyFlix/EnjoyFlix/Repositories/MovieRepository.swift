//
//  MovieRepository.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 21.07.2023.
//

import Foundation

protocol MoviesRepository: HTTPService {
    func getMovie(atPage page: Int, dataType datatype: DataType) async throws -> [MovieResponse]
}

struct MoviesRepositoryImplemented: MoviesRepository {
    func getMovie(atPage page: Int, dataType: DataType) async throws -> [MovieResponse] {
        switch dataType {
        case .nowPlaying:
            guard let url = EndpointService.Movies.nowPlaying(atPage: page) else { throw HTTPError.invalidEndpoint }
            let response: MoviesListResponse = try await handleDataTask(from: url)
            return response.results
        case .upComing:
            guard let url = EndpointService.Movies.upcoming(atPage: page) else { throw HTTPError.invalidEndpoint }
            let response: MoviesListResponse = try await handleDataTask(from: url)
            return response.results
        case .popular:
            guard let url = EndpointService.Movies.topRated(atPage: page) else { throw HTTPError.invalidEndpoint }
            let response: MoviesListResponse = try await handleDataTask(from: url)
            return response.results
        case .topRated:
            guard let url = EndpointService.Movies.popular(atPage: page) else { throw HTTPError.invalidEndpoint }
            let response: MoviesListResponse = try await handleDataTask(from: url)
            return response.results
        }
    }
}

enum DataType {
    case nowPlaying
    case upComing
    case topRated
    case popular
}
