//
//  MoviesAssembly.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 18.07.2023.
//

import Foundation
import Swinject
import UIKit


class MoviesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MoviesViewController.self) { resolver in
            let view = MoviesViewController(nibName: "MoviesViewController", bundle: nil)
            var viewModel = resolver.resolve(MoviesViewModel.self)!
            var model = resolver.resolve(MoviesModel.self)!
            
            return view
        }
        
        container.register(MoviesViewModel.self) { _ in
            MoviesViewModelImplemented()
        }
        container.register(MoviesModel.self) { _ in
            MoviesModelImplemented()
        }
    }
}

