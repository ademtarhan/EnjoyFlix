//
//  TvRepository.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 25.07.2023.
//

import Foundation

protocol TvRepository: HTTPService{
    func getTv(atPage page: Int, dataType datatype: TvState) async throws -> [TvResponse]
}


struct TvRepositoryImplemented: TvRepository{
    func getTv(atPage page: Int, dataType datatype: TvState) async throws -> [TvResponse] {
        switch datatype{
        case .popular:
            guard let url = EndpointService.Tv.popular(atPage: page) else { throw HTTPError.invalidEndpoint}
            let response: TvListResponse = try await handleDataTask(from: url)
            return response.results
        case .airingToday:
            guard let url = EndpointService.Tv.airingToday(atPage: page) else { throw HTTPError.invalidEndpoint}
            let response: TvListResponse = try await handleDataTask(from: url)
            return response.results
        case .onTv:
            guard let url = EndpointService.Tv.onTv(atPage: page) else { throw HTTPError.invalidEndpoint}
            let response: TvListResponse = try await handleDataTask(from: url)
            return response.results
        case .topRated:
            guard let url = EndpointService.Tv.topRated(atPage: page) else {
                throw HTTPError.invalidEndpoint}
            let response: TvListResponse = try await handleDataTask(from: url)
            return response.results
        }
    }
}

enum TvState {
    case onTv
    case topRated
    case airingToday
    case popular
}
