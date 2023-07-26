//
//  TvViewModel.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 25.07.2023.
//

import Combine
import Foundation
import UIKit

typealias tvSnapshotType = NSDiffableDataSourceSnapshot<TvSection, CollectionModel>

protocol TvViewModel {
    var model: TvModel? { get set }
    var snapshotPublisher: AnyPublisher<tvSnapshotType, Never> { get }
    func load()
}

class TvViewModelImplemented: TvViewModel {
    var model: TvModel?
    private let snapshot = PassthroughSubject<tvSnapshotType, Never>()
    private var snapshotModel = tvSnapshotType()
    var snapshotPublisher: AnyPublisher<tvSnapshotType, Never> {
        snapshot.eraseToAnyPublisher()
    }

    init() {
        snapshotModel.appendSections(TvSection.allCases)
    }

    func load() {
        print("--\(#function)")

        Task {
            do {
                guard let onTVResponse = try await self.model?.getTv(atPage: 1, dataType: .onTv) else {
                    throw HTTPError.invalidData
                }
                let onTVModel = onTVResponse.map {
                    TvCollectionModel(id: $0.id, title: $0.name, posterPath: $0.posterPath)
                }
                snapshotModel.appendItems(onTVModel, toSection: .onTv)
                snapshot.send(snapshotModel)

                guard let airingTodayTVResponse = try await self.model?.getTv(atPage: 1, dataType: .airingToday) else {
                    throw HTTPError.invalidData
                }

                let airingTodayTVModel = airingTodayTVResponse.map {
                    TvCollectionModel(id: $0.id, title: $0.name, posterPath: $0.posterPath)
                }
                snapshotModel.appendItems(airingTodayTVModel, toSection: .airingToday)
                snapshot.send(snapshotModel)
                // ..

                guard let topRatedMovieResponse = try await self.model?.getTv(atPage: 1, dataType: .topRated) else {
                    throw HTTPError.invalidData
                }
                let topRatedMovieModel = topRatedMovieResponse.map {
                    TvCollectionModel(id: $0.id, title: $0.name, posterPath: $0.posterPath)
                }
                snapshotModel.appendItems(topRatedMovieModel, toSection: .topRated)
                snapshot.send(snapshotModel)

                guard let populerTVResponse = try await self.model?.getTv(atPage: 1, dataType: .popular) else {
                    throw HTTPError.invalidData
                }
                let populerMovieModel = populerTVResponse.map {
                    TvCollectionModel(id: $0.id, title: $0.name, posterPath: $0.posterPath)
                }
                snapshotModel.appendItems(populerMovieModel, toSection: .popular)
                snapshot.send(snapshotModel)

            } catch {
                print(error)
            }
        }
    }
}
