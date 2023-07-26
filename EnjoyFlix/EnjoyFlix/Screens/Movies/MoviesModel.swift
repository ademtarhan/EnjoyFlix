//
//  MoviesModel.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 18.07.2023.
//

import Foundation

// TODO: Code will be optimized

protocol MoviesModel {
    func getMovie(atPage page: Int, dataType: MovieState) async throws -> [MovieResponse]
}

class MoviesModelImplemented: MoviesModel {
    var repository: MoviesRepository

    init(repository: MoviesRepository) {
        self.repository = repository
    }

    func getMovie(atPage page: Int, dataType: MovieState) async throws -> [MovieResponse] {
        try await repository.getMovie(atPage: page, dataType: dataType)
    }
}
