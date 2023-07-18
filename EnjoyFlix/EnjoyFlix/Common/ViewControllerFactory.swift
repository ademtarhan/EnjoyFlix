//
//  ViewControllerFactory.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 18.07.2023.
//

import Foundation
import Swinject

protocol ViewControllerFactory {
    var movies: MoviesViewController {get}
}

class ViewControllerFactoryImplemented: ViewControllerFactory{
    var movies: MoviesViewController { assembler.resolver.resolve(MoviesViewController.self)!}
    
    
    private let assembler: Assembler
    
    init(assembler: Assembler) {
        self.assembler = assembler
    }
    
}
