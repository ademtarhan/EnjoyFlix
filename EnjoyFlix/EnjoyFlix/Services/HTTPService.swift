//
//  HTTPService.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 18.07.2023.
//

import Foundation


protocol HTTPService {
    func handleDataTask<T:HTTPResponse>(from url: URL) async throws -> T
}


extension HTTPService{
    private var decoder: JSONDecoder {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return decoder
    }
    
    var session: URLSession{
        URLSession.shared
    }
    
    func handleDataTask<T:HTTPResponse>(from url: URL) async throws -> T {
        let (data,_) = try await session.data(from: url)
        data.printData()
        return try decoder.decode(T.self, from: data)
    }
    
}
