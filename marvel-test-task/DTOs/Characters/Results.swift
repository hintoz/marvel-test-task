//
//  Results.swift
//
//  Created by Евгений Дац on 30/10/2017
//  Copyright (c) Evgeny Dats. All rights reserved.
//

import Foundation
import ObjectMapper

public class Results: Mappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let comics = "comics"
    static let series = "series"
    static let modified = "modified"
    static let id = "id"
    static let name = "name"
    static let thumbnail = "thumbnail"
    static let urls = "urls"
    static let descriptionValue = "description"
    static let stories = "stories"
    static let resourceURI = "resourceURI"
    static let events = "events"
  }

  // MARK: Properties
  public var comics: Comics?
  public var series: Series?
  public var modified: String?
  public var id: Int?
  public var name: String?
  public var thumbnail: Thumbnail?
  public var urls: [Urls]?
  public var descriptionValue: String?
  public var stories: Stories?
  public var resourceURI: String?
  public var events: Events?

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
    comics <- map[SerializationKeys.comics]
    series <- map[SerializationKeys.series]
    modified <- map[SerializationKeys.modified]
    id <- map[SerializationKeys.id]
    name <- map[SerializationKeys.name]
    thumbnail <- map[SerializationKeys.thumbnail]
    urls <- map[SerializationKeys.urls]
    descriptionValue <- map[SerializationKeys.descriptionValue]
    stories <- map[SerializationKeys.stories]
    resourceURI <- map[SerializationKeys.resourceURI]
    events <- map[SerializationKeys.events]
  }
}
