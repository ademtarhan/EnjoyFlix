//
//  TvModel.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 25.07.2023.
//

import Foundation

protocol TvModel {
    func getTv(atPage page: Int, dataType: TvState) async throws -> [TvResponse]
}

class TvModelImplemented: TvModel {
    var repository: TvRepository

    init(repository: TvRepository) {
        self.repository = repository
    }

    func getTv(atPage page: Int, dataType: TvState) async throws -> [TvResponse] {
        let data = try await repository.getTv(atPage: page, dataType: dataType)
        return data
    }
}
