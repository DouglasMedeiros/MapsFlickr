//
//  PhotoAnnotationTests.swift
//  MapsFlickr
//
//  Created by Douglas Brito de Medeiros on 5/24/16.
//  Copyright © 2016 CodeNetworks. All rights reserved.
//

import XCTest
import CoreLocation

@testable import MapsFlickr

class PhotoAnnotationTests: XCTestCase {

    var annotation: PhotoAnnotation!

    override func setUp() {
        super.setUp()

        let photo = Photo()
        photo.title = "Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos"
        photo.url_m = "http://site.com/photoMedium.jpg"
        photo.url_t = "http://site.com/photoThumb.jpg"

        photo.latitude = "-45.0411545564247"
        photo.longitude = "-74.7949287047143"

        self.annotation = PhotoAnnotation(photo: photo)
    }
    
    override func tearDown() {
        super.tearDown()
    }

    // MARK: Tests
    func testInstanceData() {
        XCTAssertNil(self.annotation.subtitle)

        XCTAssertNotNil(self.annotation.cachedBigImage)
        XCTAssertNotNil(self.annotation.cachedThumbnailImage)
        XCTAssertNotNil(self.annotation.coordinate)

        XCTAssertTrue(self.annotation.cachedBigImage.isKindOfClass(UIImage))
        XCTAssertTrue(self.annotation.cachedThumbnailImage.isKindOfClass(UIImage))

        XCTAssertEqual("-45.0411545564247", "\(self.annotation.coordinate.latitude)")
        XCTAssertEqual("-74.7949287047143", "\(self.annotation.coordinate.longitude)")
    }
    
}
