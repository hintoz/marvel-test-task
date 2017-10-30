//
//  Config.swift
//  marvel-test-task
//
//  Created by Евгений Дац on 30.10.2017.
//  Copyright © 2017 Evgeny Dats. All rights reserved.
//

import Foundation
import CryptoSwift

class Config {
    
    struct marvel {
        static let base = "https://gateway.marvel.com/v1/public/"
        static let publicKey = "7cafae6b8ef0535d730b6976b4c51e1c"
        static let privateKey = "cc2e9843f01f232f02e1b52f8d2a370d55ec1a8c"
        static let timeStamp = Date().timeStamp
        static let hash = "\(timeStamp)\(privateKey)\(publicKey)".md5()
        
        static let limit = 20
    }
}
