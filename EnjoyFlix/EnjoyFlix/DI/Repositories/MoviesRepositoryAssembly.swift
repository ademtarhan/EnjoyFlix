//
//  MoviesRepositoryAssembly.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 21.07.2023.
//

import Foundation
import Swinject

class MoviesRepositoryAssembly: Assembly{
    func assemble(container: Container) {
        container.register(MoviesRepository.self) { _ in
            MoviesRepositoryImplemented()
        }
    }
}
