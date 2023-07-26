//
//  CollectionSection.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 21.07.2023.
//

import Foundation

protocol CollectionSection: CaseIterable {
    var id: Int { get }
    var title: String? { get }

    init?(fromId id: Int)
}

enum MoviesSection: CollectionSection {
    case nowPlaying
    case upcoming
    case topRated
    case popular

    var id: Int {
        switch self {
        case .nowPlaying:
            return 0
        case .upcoming:
            return 1
        case .topRated:
            return 2
        case .popular:
            return 3
        }
    }

    var title: String? {
        switch self {
        case .nowPlaying:
            return nil
        case .upcoming:
            return "UPCOMING"
        case .topRated:
            return "TOP RATED"
        case .popular:
            return "POPULAR"
        }
    }

    init?(fromId id: Int) {
        switch id {
        case 0:
            self = .nowPlaying
        case 1:
            self = .upcoming
        case 2:
            self = .topRated
        case 3:
            self = .popular
        default:
            return nil
        }
    }
}

enum TvSection: CollectionSection {
    case onTv
    case topRated
    case airingToday
    case popular

    var id: Int {
        switch self {
        case .popular:
            return 0
        case .airingToday:
            return 1
        case .onTv:
            return 2
        case .topRated:
            return 3
        }
    }

    var title: String? {
        switch self {
        case .onTv:
            return nil
        case .topRated:
            return "TOP RATED"
        case .airingToday:
            return "AIRING TODAY"
        case .popular:
            return "POPULAR"
        }
    }

    init?(fromId id: Int) {
        switch id {
        case 0:
            self = .onTv
        case 1:
            self = .topRated
        case 2:
            self = .airingToday
        case 3:
            self = .popular
        default:
            return nil
        }
    }
}
