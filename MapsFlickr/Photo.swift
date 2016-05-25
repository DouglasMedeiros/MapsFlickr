//
//  Photo.swift
//  MapsFlickr
//
//  Created by Douglas Brito de Medeiros on 5/24/16.
//  Copyright © 2016 CodeNetworks. All rights reserved.
//

import ObjectMapper

class Photo: Mappable {

    var title: String = ""

    var url_m: String = ""
    var url_t: String = ""

    var latitude: String = ""
    var longitude: String = ""

    init() {}

    required init?(_ map: Map) {}

    var routeThumb: NSURL? {
        return NSURL(string: self.url_t)
    }

    var routeBig: NSURL? {
        return NSURL(string: self.url_m)
    }

    func mapping(map: Map) {
        title <- map["title"]
        url_m <- map["url_m"]
        url_t <- map["url_t"]

        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }
}
