//
//  TvRepository.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 25.07.2023.
//

import Foundation

protocol SeriesRepository: HTTPService{
    func getSeries(atPage page: Int, dataType datatype: SeriesState) async throws -> [SeriesResponse]
}


struct SeriesRepositoryImplemented: SeriesRepository{
    func getSeries(atPage page: Int, dataType datatype: SeriesState) async throws -> [SeriesResponse] {
        switch datatype{
        case .popular:
            guard let url = EndpointService.Series.popular(atPage: page) else { throw HTTPError.invalidEndpoint}
            let response: SeriesListResponse = try await handleDataTask(from: url)
            return response.results
        case .airingToday:
            guard let url = EndpointService.Series.airingToday(atPage: page) else { throw HTTPError.invalidEndpoint}
            let response: SeriesListResponse = try await handleDataTask(from: url)
            return response.results
        case .onTv:
            guard let url = EndpointService.Series.onTv(atPage: page) else { throw HTTPError.invalidEndpoint}
            let response: SeriesListResponse = try await handleDataTask(from: url)
            return response.results
        case .topRated:
            guard let url = EndpointService.Series.topRated(atPage: page) else {
                throw HTTPError.invalidEndpoint}
            let response: SeriesListResponse = try await handleDataTask(from: url)
            return response.results
        }
    }
}

enum SeriesState {
    case onTv
    case topRated
    case airingToday
    case popular
}
