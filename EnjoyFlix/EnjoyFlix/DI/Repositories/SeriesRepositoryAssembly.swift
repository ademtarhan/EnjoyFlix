//
//  SeriesRepositoryAssembly().swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 25.07.2023.
//

import Foundation
import Swinject

class SeriesRepositoryAssembly: Assembly{
    func assemble(container: Container) {
        container.register(SeriesRepository.self) { _ in
            SeriesRepositoryImplemented()
        }
    }
}
