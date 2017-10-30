//
//  RequestFactory.swift
//  marvel-test-task
//
//  Created by Евгений Дац on 30.10.2017.
//  Copyright © 2017 Evgeny Dats. All rights reserved.
//

import Foundation
import Alamofire

class RequestFactory {
    let baseAPIURL: String
    
    init() {
        baseAPIURL = Config.marvel.base
    }
    
    func receiveCharactersRequest(offset: Int) -> DataRequest {
        let parameters = ["offset": "\(offset)",
                          "limit": "\(Config.marvel.limit)",
                          "ts": "\(Config.marvel.timeStamp)",
                          "apikey": Config.marvel.publicKey,
                          "hash": Config.marvel.hash
            ]
        let requestUrl = baseAPIURL + "characters"
        return Alamofire.request(requestUrl, method: .get, parameters: parameters)
    }
}
