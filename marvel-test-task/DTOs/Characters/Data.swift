//
//  Data.swift
//
//  Created by Евгений Дац on 30/10/2017
//  Copyright (c) Evgeny Dats. All rights reserved.
//

import Foundation
import ObjectMapper

public class Data: Mappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let offset = "offset"
    static let total = "total"
    static let limit = "limit"
    static let results = "results"
    static let count = "count"
  }

  // MARK: Properties
  public var offset: Int?
  public var total: Int?
  public var limit: Int?
  public var results: [Results]?
  public var count: Int?

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
    offset <- map[SerializationKeys.offset]
    total <- map[SerializationKeys.total]
    limit <- map[SerializationKeys.limit]
    results <- map[SerializationKeys.results]
    count <- map[SerializationKeys.count]
  }
}
