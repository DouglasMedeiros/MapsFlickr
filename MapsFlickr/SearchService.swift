//
//  SearchService.swift
//  MapsFlickr
//
//  Created by Douglas Brito de Medeiros on 5/24/16.
//  Copyright © 2016 CodeNetworks. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import CoreLocation

extension APIManager {
    func searchPhotosFromLocation(position position: (CLLocationCoordinate2D, CLLocationCoordinate2D),
                                  completionHandler: (response: Response<[Photo], NSError>) -> Void) -> Request {

        let apiKey = Constants.Config.Flickr.APIKey
        let host = Constants.Config.Flickr.Host
        
        let url = NSMutableURLRequest(URL: NSURL(string: "\(host)/services/rest/?method=flickr.photos.search&format=json&api_key=\(apiKey)&bbox=\(position.0.longitude),\(position.0.latitude),\(position.1.longitude),\(position.1.latitude)&extras=geo,url_t,url_m&per_page=100&nojsoncallback=1")!)

        return self.manager.request(.GET, url,
            parameters: nil,
            encoding: ParameterEncoding.JSON,
            headers: nil
            )
            .log(level: .Verbose)
            .validate()
            .responseArray(queue: nil, keyPath: "photos.photo", completionHandler: { (response: Response<[Photo], NSError>) -> Void in
                completionHandler(response: response)
        })
    }
}
