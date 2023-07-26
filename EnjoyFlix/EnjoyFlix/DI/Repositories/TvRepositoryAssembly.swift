//
//  TvRepositoryAssembly().swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 25.07.2023.
//

import Foundation
import Swinject

class TvRepositoryAssembly: Assembly{
    func assemble(container: Container) {
        container.register(TvRepository.self) { _ in
            TvRepositoryImplemented()
        }
    }
}
