//
//  MovieRepository.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 21.07.2023.
//

import Foundation

protocol MoviesRepository: HTTPService {
    func getNowPlaying(atPage page: Int) async throws -> [MovieResponse]
    func getUpcoming(atPage page: Int) async throws -> [MovieResponse]
    func getTopRated(atPage page: Int) async throws -> [MovieResponse]
    func getPopular(atPage page: Int) async throws -> [MovieResponse]
}


struct MoviesRepositoryImplemented: MoviesRepository {
    func getNowPlaying(atPage page: Int) async throws -> [MovieResponse] {
        guard let url = EndpointService.Movies.nowPlaying(atPage: page) else { throw HTTPError.invalidEndpoint }

        let response: MoviesListResponse = try await handleDataTask(from: url)
        return response.results
    }
    
    func getUpcoming(atPage page: Int) async throws -> [MovieResponse] {
        guard let url = EndpointService.Movies.upcoming(atPage: page) else { throw HTTPError.invalidEndpoint }

        let response: MoviesListResponse = try await handleDataTask(from: url)
        return response.results
    }
    
    func getTopRated(atPage page: Int) async throws -> [MovieResponse] {
        guard let url = EndpointService.Movies.topRated(atPage: page) else { throw HTTPError.invalidEndpoint }

        let response: MoviesListResponse = try await handleDataTask(from: url)
        return response.results
    }
    
    func getPopular(atPage page: Int) async throws -> [MovieResponse] {
        guard let url = EndpointService.Movies.popular(atPage: page) else { throw HTTPError.invalidEndpoint }

        let response: MoviesListResponse = try await handleDataTask(from: url)
        return response.results
    }
}
