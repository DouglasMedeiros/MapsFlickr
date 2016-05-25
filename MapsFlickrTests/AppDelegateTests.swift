//
//  AppDelegateTests.swift
//  MapsFlickr
//
//  Created by Douglas Brito de Medeiros on 5/24/16.
//  Copyright © 2016 CodeNetworks. All rights reserved.
//

import XCTest
import UIKit

@testable import MapsFlickr

class AppDelegateTests: XCTestCase {

    var application: UIApplication?
    var appDelegate: AppDelegate?

    override func setUp() {
        super.setUp()

        application = UIApplication.sharedApplication()
        appDelegate = AppDelegate()
        appDelegate?.application(application!, didFinishLaunchingWithOptions: nil)

        sleep(1)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testRootViewControllerIsHomeViewControllerController() {
        let window = appDelegate?.window
        let rootViewController = window!.rootViewController
        XCTAssert((rootViewController?.isKindOfClass(MapViewController)) != nil)
    }

    func testWindowIsKeyAfterAppIsLaunched() {
        XCTAssertTrue((appDelegate?.window?.keyWindow) != nil)
    }
}
