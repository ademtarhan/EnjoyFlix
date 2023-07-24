//
//  MoviesViewModel.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 18.07.2023.
//

import Combine
import Foundation
import UIKit

typealias moviesSnapshotType = NSDiffableDataSourceSnapshot<MoviesSection, CollectionModel>

protocol MoviesViewModel {
    var model: MoviesModel! { get set }

    var snapshotPublisher: AnyPublisher<moviesSnapshotType, Never> { get }

    func load()
}

class MoviesViewModelImplemented: MoviesViewModel {
    var model: MoviesModel!

    private let snapshot = PassthroughSubject<moviesSnapshotType, Never>()
    private var snapshotModel = moviesSnapshotType()

    var snapshotPublisher: AnyPublisher<moviesSnapshotType, Never> {
        snapshot.eraseToAnyPublisher()
    }

    init() {
        snapshotModel.appendSections(MoviesSection.allCases)
    }

    func load() {
        print(#function)

        Task {
            do {
                //let nowPlayingResponse = try await model.getNowPlaying(atPage: 1)
                let nowPlayingResponse = try await model.getMovie(atPage: 1, dataType: .nowPlaying)
                let nowPlayingModels = nowPlayingResponse.map {
                    MovieCollectionModel(id: $0.id,
                                         title: $0.title,
                                         posterPath: $0.posterPath)
                }

                snapshotModel.appendItems(nowPlayingModels, toSection: .nowPlaying)
                snapshot.send(snapshotModel)

                
                //let upcomingResponse = try await model.getUpcoming(atPage: 1)
                let upcomingResponse = try await model.getMovie(atPage: 1, dataType: .upComing)
                
                let upcomingModels = upcomingResponse.map {
                    MovieCollectionModel(id: $0.id,
                                         title: $0.title,
                                         posterPath: $0.posterPath)
                }

                snapshotModel.appendItems(upcomingModels, toSection: .upcoming)
                snapshot.send(snapshotModel)

                //let topRatedResponse = try await model.getTopRated(atPage: 1)
                let topRatedResponse = try await model.getMovie(atPage: 1, dataType: .topRated)
                let topRatedModels = topRatedResponse.map {
                    MovieCollectionModel(id: $0.id,
                                         title: $0.title,
                                         posterPath: $0.posterPath)
                }

                snapshotModel.appendItems(topRatedModels, toSection: .topRated)
                snapshot.send(snapshotModel)

                //let popularResponse = try await model.getPopular(atPage: 1)
                let popularResponse = try await model.getMovie(atPage: 1, dataType: .popular)
                let popularModels = popularResponse.map {
                    MovieCollectionModel(id: $0.id,
                                         title: $0.title,
                                         posterPath: $0.posterPath)
                }

                snapshotModel.appendItems(popularModels, toSection: .popular)
                snapshot.send(snapshotModel)

            } catch {
                print(error)
            }
        }
    }
}
