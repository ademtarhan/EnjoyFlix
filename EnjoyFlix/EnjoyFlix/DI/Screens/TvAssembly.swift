//
//  TvAssembly.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 25.07.2023.
//

import Foundation
import Swinject

class TvAssembly: Assembly {
    func assemble(container: Container) {
        container.register(TvViewController.self) { resolver in
            let view = TvViewController(nibName: "TvViewController", bundle: nil)
            var viewModel = resolver.resolve(TvViewModel.self)!
            var model = resolver.resolve(TvModel.self)!

            view.viewModel = viewModel
            viewModel.model = model
            return view
        }
        container.register(TvViewModel.self) { _ in
            TvViewModelImplemented()
        }
        container.register(TvModel.self) { resolver in
            TvModelImplemented(repository: resolver.resolve(TvRepository.self)!)
        }
    }
}
