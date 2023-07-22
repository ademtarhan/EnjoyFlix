//
//  HTTPError.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 18.07.2023.
//

import Foundation

enum HTTPError: Error, CustomStringConvertible{
    case failed
    case invalidEndpoint
    case invalidData
}



extension HTTPError{
    var description: String{
        switch self{
        case .failed:
            return "Failed to connect"
        case .invalidEndpoint:
            return "Invalid endpoint"
        case .invalidData:
            return "Invalid data"
        }
    }
}
