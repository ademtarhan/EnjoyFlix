//
//  AppAssembler.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 18.07.2023.
//

import Foundation
import Swinject
import UIKit

class AppAssembler {
    static let shared = AppAssembler()

    private(set) var assembler: Assembler?

    func initDI() {
        assembler = Assembler([
                MoviesAssembly(),
                
                
                MoviesRepositoryAssembly(),
        ])
        assembler?.apply(assembly: ViewControllerFactoryAssembly(assembler: assembler!))
    }
}
