//
//   Put the code you want to measure the time of here.swift
//  MapsFlickr
//
//  Created by Douglas Brito de Medeiros on 5/24/16.
//  Copyright © 2016 CodeNetworks. All rights reserved.
//

import XCTest
import MapKit
import CoreLocation

@testable import MapsFlickr

class MapViewControllerTests: XCTestCase {

    var controller: MapViewController!

    override func setUp() {
        super.setUp()

        self.controller = MapViewController()
        if(self.controller != nil) {
            self.controller.loadView()
            self.controller.viewDidLoad()
        }
    }
    
    override func tearDown() {
        super.tearDown()
    }

    // MARK: Tests
    func testSetupView() {
        XCTAssertNotNil(self.controller.mapView)
        XCTAssertNotNil(self.controller.locationManager)
    }

    func testInstance() {
        XCTAssertTrue(self.controller.mapView.isKindOfClass(MKMapView))
        XCTAssertTrue(self.controller.locationManager.isKindOfClass(CLLocationManager))
    }

    func testStarting() {
        XCTAssertFalse(MapViewController.startedUserLocation)
    }

}
