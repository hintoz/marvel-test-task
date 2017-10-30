//
//  Comics.swift
//
//  Created by Евгений Дац on 30/10/2017
//  Copyright (c) Evgeny Dats. All rights reserved.
//

import Foundation
import ObjectMapper

public class Comics: Mappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let items = "items"
    static let available = "available"
    static let returned = "returned"
    static let collectionURI = "collectionURI"
  }

  // MARK: Properties
  public var items: [Items]?
  public var available: Int?
  public var returned: Int?
  public var collectionURI: String?

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
    items <- map[SerializationKeys.items]
    available <- map[SerializationKeys.available]
    returned <- map[SerializationKeys.returned]
    collectionURI <- map[SerializationKeys.collectionURI]
  }
}
