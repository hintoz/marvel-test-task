//
//  ModelsAssembly.swift
//  marvel-test-task
//
//  Created by Евгений Дац on 30.10.2017.
//  Copyright © 2017 Evgeny Dats. All rights reserved.
//

import Foundation
import Dip

class ModelsAssembly {
    static func assembly() -> DependencyContainer {
        return DependencyContainer { container in
            unowned let container = container
            
            container.register(ComponentScope.singleton) {
                ManagerImp() as Manager
            }
            container.register { try CharactersModel(manager: container.resolve()) }
            
        }
    }
}
