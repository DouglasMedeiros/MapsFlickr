//
//  PhotoAnnotation.swift
//  MapsFlickr
//
//  Created by Douglas Brito de Medeiros on 5/24/16.
//  Copyright © 2016 CodeNetworks. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation
import Haneke

class PhotoAnnotation: NSObject, MKAnnotation {

    var cachedBigImage: UIImage
    var cachedThumbnailImage: UIImage

    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?

    var photo: Photo!

    init(photo: Photo){
        self.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(photo.latitude)!, CLLocationDegrees(photo.longitude)!)

        self.cachedBigImage = UIImage()
        self.cachedThumbnailImage = UIImage()

        self.photo = photo
        self.title = photo.title
    }

    func preloadImages() {
        let cache = Shared.imageCache

        let fetcherThumb = NetworkFetcher<UIImage>(URL: photo.routeThumb!)
        cache.fetch(fetcher: fetcherThumb).onSuccess { image in
            self.cachedThumbnailImage = image
        }

        let fetcherBig = NetworkFetcher<UIImage>(URL: photo.routeBig!)
        cache.fetch(fetcher: fetcherBig).onSuccess { image in
            self.cachedBigImage = image
        }
    }
}
