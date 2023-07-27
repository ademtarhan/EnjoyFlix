//
//  TvModel.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 25.07.2023.
//

import Foundation

protocol SeriesModel {
    func getSeries(atPage page: Int, dataType: SeriesState) async throws -> [SeriesResponse]
}

class SeriesModelImplemented: SeriesModel {
    var repository: SeriesRepository

    init(repository: SeriesRepository) {
        self.repository = repository
    }

    func getSeries(atPage page: Int, dataType: SeriesState) async throws -> [SeriesResponse] {
        let data = try await repository.getSeries(atPage: page, dataType: dataType)
        return data
    }
}
