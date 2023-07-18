//
//  ViewControllerFactoryAssembly.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 18.07.2023.
//

import Foundation
import Swinject

class ViewControllerFactoryAssembly: Assembly{
    private let assembler :Assembler
    
    init(assembler: Assembler) {
        self.assembler = assembler
    }
    
    func assemble(container: Container) {
        container.register(ViewControllerFactory.self) { _ in
            ViewControllerFactoryImplemented(assembler: self.assembler)
        }
    }
}
