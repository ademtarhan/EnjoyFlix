//
//  TvViewModel.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 25.07.2023.
//

import Combine
import Foundation
import UIKit

typealias seriesSnapshotType = NSDiffableDataSourceSnapshot<SeriesSection, CollectionModel>

protocol SeriesViewModel {
    var model: SeriesModel? { get set }
    var snapshotPublisher: AnyPublisher<seriesSnapshotType, Never> { get }
    func load()
}

class SeriesViewModelImplemented: SeriesViewModel {
    var model: SeriesModel?
    private let snapshot = PassthroughSubject<seriesSnapshotType, Never>()
    private var snapshotModel = seriesSnapshotType()
    var snapshotPublisher: AnyPublisher<seriesSnapshotType, Never> {
        snapshot.eraseToAnyPublisher()
    }

    init() {
        snapshotModel.appendSections(SeriesSection.allCases)
    }

    func load() {
        print("--\(#function)")

        Task {
            do {
                guard let onTVResponse = try await self.model?.getSeries(atPage: 1, dataType: .onTv) else {
                    throw HTTPError.invalidData
                }
                let onTVModel = onTVResponse.map {
                    SeriesCollectionModel(id: $0.id, title: $0.name, posterPath: $0.posterPath)
                }
                snapshotModel.appendItems(onTVModel, toSection: .onTv)
                snapshot.send(snapshotModel)

                guard let airingTodaySeriesResponse = try await self.model?.getSeries(atPage: 1, dataType: .airingToday) else {
                    throw HTTPError.invalidData
                }

                let airingTodaySeriesModel = airingTodaySeriesResponse.map {
                    SeriesCollectionModel(id: $0.id, title: $0.name, posterPath: $0.posterPath)
                }
                snapshotModel.appendItems(airingTodaySeriesModel, toSection: .airingToday)
                snapshot.send(snapshotModel)
                // ..

                guard let topRatedSeriesResponse = try await self.model?.getSeries(atPage: 1, dataType: .topRated) else {
                    throw HTTPError.invalidData
                }
                let topRatedSeriesModel = topRatedSeriesResponse.map {
                    SeriesCollectionModel(id: $0.id, title: $0.name, posterPath: $0.posterPath)
                }
                snapshotModel.appendItems(topRatedSeriesModel, toSection: .topRated)
                snapshot.send(snapshotModel)

                guard let populerSeriesResponse = try await self.model?.getSeries(atPage: 1, dataType: .popular) else {
                    throw HTTPError.invalidData
                }
                let populerSeriesModel = populerSeriesResponse.map {
                    SeriesCollectionModel(id: $0.id, title: $0.name, posterPath: $0.posterPath)
                }
                snapshotModel.appendItems(populerSeriesModel, toSection: .popular)
                snapshot.send(snapshotModel)

            } catch {
                print(error)
            }
        }
    }
}
