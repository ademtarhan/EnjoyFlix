//
//  TvAssembly.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 25.07.2023.
//

import Foundation
import Swinject

class SeriesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SeriesViewController.self) { resolver in
            let view = SeriesViewController(nibName: "SeriesViewController", bundle: nil)
            var viewModel = resolver.resolve(SeriesViewModel.self)!
            var model = resolver.resolve(SeriesModel.self)!

            view.viewModel = viewModel
            viewModel.model = model
            return view
        }
        container.register(SeriesViewModel.self) { _ in
            SeriesViewModelImplemented()
        }
        container.register(SeriesModel.self) { resolver in
            SeriesModelImplemented(repository: resolver.resolve(SeriesRepository.self)!)
        }
    }
}
