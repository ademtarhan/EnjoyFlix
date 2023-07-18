//
//  MoviesAssemblyAssembly.swift
//  EnjoyFlix
//
//  Created Adem Tarhan on 18.07.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Swinject
import UIKit

class MoviesAssemblyAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MoviesAssemblyViewController.self) { r in
            let viewController = MoviesAssemblyViewControllerImpl(nibName: "MoviesAssemblyViewController", bundle: nil)
            let presenter = r.resolve(MoviesAssemblyPresenter.self)!
            let interactor = r.resolve(MoviesAssemblyInteractor.self)!
            let router = r.resolve(MoviesAssemblyRouter.self)!

            presenter.view = viewController
            presenter.router = router
            presenter.interactor = interactor
            viewController.presenter = presenter
            router.view = viewController

            return viewController
        }

        container.register(MoviesAssemblyPresenter.self) { _ in
            MoviesAssemblyPresenterImpl()
        }

        container.register(MoviesAssemblyInteractor.self) { r in
            MoviesAssemblyInteractorImpl(service: r.resolve(MoviesAssemblyService.self)!)
        }

        container.register(MoviesAssemblyRouter.self) { r in
            MoviesAssemblyRouterImpl(factory: r.resolve(ViewControllerFactory.self)!)
        }
        
        container.register(MoviesAssemblyService.self) { r in
            MoviesAssemblyServiceImpl()
        }
    }
}
