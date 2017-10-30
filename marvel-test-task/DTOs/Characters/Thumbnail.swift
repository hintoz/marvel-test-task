//
//  Thumbnail.swift
//
//  Created by Евгений Дац on 30/10/2017
//  Copyright (c) Evgeny Dats. All rights reserved.
//

import Foundation
import ObjectMapper

public class Thumbnail: Mappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let extens = "extension"
    static let path = "path"
  }

  // MARK: Properties
  public var extens: String?
  public var path: String?

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
    extens <- map[SerializationKeys.extens]
    path <- map[SerializationKeys.path]
  }

}
