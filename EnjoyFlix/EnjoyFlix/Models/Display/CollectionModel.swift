//
//  CollectionModel.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 21.07.2023.
//

import Foundation

class CollectionModel: Hashable{
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: CollectionModel, rhs: CollectionModel) -> Bool {
        lhs.id == rhs.id
    }
    
}


class MovieCollectionModel: CollectionModel {
    let title: String
    let posterURL: URL?
    
    init(id: Int, title: String, posterPath: String) {
        self.title = title
        self.posterURL = EndpointService.Movies.poster(ofMovie: posterPath)
        super.init(id: id)
    }
}


class SeriesCollectionModel: CollectionModel {
    let title: String
    let posterURL: URL?
    
    init(id: Int, title: String, posterPath: String?) {
        self.title = title
        self.posterURL = EndpointService.Series.poster(ofMovie: posterPath)
        super.init(id: id)
    }
}
