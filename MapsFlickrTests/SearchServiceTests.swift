//
//  SearchServiceTests.swift
//  MapsFlickr
//
//  Created by Douglas Brito de Medeiros on 5/24/16.
//  Copyright © 2016 CodeNetworks. All rights reserved.
//

import XCTest
import CoreLocation
import Alamofire
import AlamofireObjectMapper

@testable import MapsFlickr

class SearchServiceTests: XCTestCase {

    var service: APIManager!

    override func setUp() {
        super.setUp()

        self.service = APIManager.sharedInstance
    }
    
    override func tearDown() {
        super.tearDown()
    }

    // MARK: Tests
    func testSearchPhotos() {

        let expectation = expectationWithDescription("SucessBlock")


        let left = CLLocationCoordinate2DMake(CLLocationDegrees("-45.0411545564247")!,
                                                  CLLocationDegrees("-74.7949287047143")!)

        let right = CLLocationCoordinate2DMake(CLLocationDegrees("21.0288531663584")!,
                                              CLLocationDegrees("-34.1894462952857")!)

        self.service.searchPhotosFromLocation(position: (left, right)) { (response) in

            XCTAssertNotNil(response)
            XCTAssertNil(response.result.error)

            if let HTTPResponse = response.response,
                responseURL = HTTPResponse.URL,
                MIMEType = HTTPResponse.MIMEType
            {
                if let json = response.result.value {
                    XCTAssertNotNil(json)
                } else {
                    XCTFail("Result invalid")
                }

                XCTAssertEqual(responseURL.absoluteString, "https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&api_key=de588f636351940ff7e359de88f122d0&bbox=-74.7949287047143,-45.0411545564247,-34.1894462952857,21.0288531663584&extras=geo,url_t,url_m&per_page=100&nojsoncallback=1")
                XCTAssertEqual(HTTPResponse.statusCode, 200)
                XCTAssertEqual(MIMEType, "application/json")
            } else {
                XCTFail("Response was not NSHTTPURLResponse")
            }

            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5.0, handler:nil)
    }
}
