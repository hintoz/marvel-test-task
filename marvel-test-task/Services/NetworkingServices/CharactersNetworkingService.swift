//
//  CharactersNetworkingService.swift
//  marvel-test-task
//
//  Created by Евгений Дац on 30.10.2017.
//  Copyright © 2017 Evgeny Dats. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class CharactersNetworkingService {
    var requestFactory: RequestFactory
    
    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
    }
    
    func receiveCharacters(offset: Int, completed: @escaping (_ responseObject: CharactersResponse?, _ error: Error?) -> ()) {
        requestFactory.receiveCharactersRequest(offset: offset)
            .responseObject { (response: DataResponse<CharactersResponse>) in
                switch response.result {
                case .success:
                    if response.response?.statusCode == 200 {
                        completed(response.result.value, nil)
                    }
                    break
                case .failure(let error):
                    completed(nil, error)
                }
        }
    }
}
