//
//  PhotoDetailViewControllerTests.swift
//  MapsFlickr
//
//  Created by Douglas Brito de Medeiros on 5/24/16.
//  Copyright © 2016 CodeNetworks. All rights reserved.
//

import XCTest
@testable import MapsFlickr

class PhotoDetailViewControllerTests: XCTestCase {

    var controller: PhotoDetailViewController!

    override func setUp() {
        super.setUp()

        let photo = Photo()
        photo.title = "Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos"
        photo.url_m = "http://site.com/photoMedium.jpg"
        photo.url_t = "http://site.com/photoThumb.jpg"

        photo.latitude = "-45.0411545564247"
        photo.longitude = "-74.7949287047143"

        let photoAnnotation = PhotoAnnotation(photo: photo)
        self.controller = PhotoDetailViewController(photoAnnotation: photoAnnotation)

        if(self.controller != nil) {
            self.controller.loadView()
            self.controller.viewDidLoad()
        }
    }
    
    override func tearDown() {
        super.tearDown()
    }

    // MARK: Tests
    func testOutlets() {
        XCTAssertNotNil(self.controller.photoTitle)
        XCTAssertNotNil(self.controller.photoImage)
    }

    func testData() {
        XCTAssertEqual(self.controller.photoTitle.text, "Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos")
    }

}
