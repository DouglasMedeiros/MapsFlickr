//
//  PhotoTests.swift
//  MapsFlickr
//
//  Created by Douglas Brito de Medeiros on 5/24/16.
//  Copyright © 2016 CodeNetworks. All rights reserved.
//
import XCTest

@testable import MapsFlickr

class PhotoTests: XCTestCase {

    var model: Photo!

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    // MARK: Tests
    func testRaw() {
        let photo = Photo()
        photo.title = "Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos"
        photo.url_m = "http://site.com/photoMedium.jpg"
        photo.url_t = "http://site.com/photoThumb.jpg"

        photo.latitude = "-45.0411545564247"
        photo.longitude = "-74.7949287047143"

        XCTAssertEqual(photo.title, "Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos")
        XCTAssertEqual(photo.url_m, "http://site.com/photoMedium.jpg")
        XCTAssertEqual(photo.url_t, "http://site.com/photoThumb.jpg")

        XCTAssertNotNil(photo.routeThumb)
        XCTAssertNotNil(photo.routeBig)

        XCTAssertNotNil(photo.latitude)
        XCTAssertNotNil(photo.longitude)

        XCTAssertTrue(photo.routeThumb!.isKindOfClass(NSURL))
        XCTAssertTrue(photo.routeBig!.isKindOfClass(NSURL))
    }

    func testMapper() {
        let photo = try! Fixture("PhotoResponse").mapTo(Photo.self)

        XCTAssertEqual(photo!.title, "Photo Sample")
        XCTAssertEqual(photo!.longitude, "-49.941964")
        XCTAssertEqual(photo!.latitude, "-22.948114")

        XCTAssertEqual(photo!.url_t, "https://farm8.staticflickr.com/7505/27230738965_21d4a380d3_t.jpg")
        XCTAssertEqual(photo!.url_m, "https://farm8.staticflickr.com/7505/27230738965_21d4a380d3.jpg")
    }


}
