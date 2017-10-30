//
//  CharactersModel.swift
//  marvel-test-task
//
//  Created by Евгений Дац on 30.10.2017.
//  Copyright © 2017 Evgeny Dats. All rights reserved.
//

import Foundation

class CharactersModel {
    var items = [Results]()
    var offset = 0
    
    let networkingService: CharactersNetworkingService
    
    init(manager: Manager) {
        networkingService = CharactersNetworkingService(requestFactory: manager.requestFactory)
    }
    
    func loadCharacters(completed: @escaping (_ count: Int?) -> ()) {
        networkingService.receiveCharacters(offset: offset) { [weak self] (response, error) in
            guard let strongSelf = self else { return }
            if let itemsData = response {
                strongSelf.offset += Config.marvel.limit
                strongSelf.items.append(contentsOf: (itemsData.data?.results)!)
                completed(itemsData.data?.results?.count)
            } else {
                debugPrint("[!ERROR]: \(String(describing: error?.localizedDescription))")
                completed(nil)
            }
        }
    }
    
    func refresh() {
        offset = 0
        items.removeAll()
    }
}
