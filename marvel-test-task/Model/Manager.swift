//
//  Manager.swift
//  marvel-test-task
//
//  Created by Евгений Дац on 30.10.2017.
//  Copyright © 2017 Evgeny Dats. All rights reserved.
//

import Foundation

protocol Manager: class {
    var requestFactory: RequestFactory { get }
}

class ManagerImp: Manager {
    let requestFactory: RequestFactory
    
    init() {
        requestFactory = RequestFactory()
    }
}
