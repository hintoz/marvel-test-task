//
//  CharactersResponse.swift
//
//  Created by Евгений Дац on 30/10/2017
//  Copyright (c) Evgeny Dats. All rights reserved.
//

import Foundation
import ObjectMapper

public class CharactersResponse: Mappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let copyright = "copyright"
        static let status = "status"
        static let data = "data"
        static let attributionText = "attributionText"
        static let code = "code"
        static let etag = "etag"
        static let attributionHTML = "attributionHTML"
    }
    
    // MARK: Properties
    public var copyright: String?
    public var status: String?
    public var data: Data?
    public var attributionText: String?
    public var code: Int?
    public var etag: String?
    public var attributionHTML: String?
    
    // MARK: ObjectMapper Initializers
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public required init?(map: Map){
        
    }
    
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public func mapping(map: Map) {
        copyright <- map[SerializationKeys.copyright]
        status <- map[SerializationKeys.status]
        data <- map[SerializationKeys.data]
        attributionText <- map[SerializationKeys.attributionText]
        code <- map[SerializationKeys.code]
        etag <- map[SerializationKeys.etag]
        attributionHTML <- map[SerializationKeys.attributionHTML]
    }
}

