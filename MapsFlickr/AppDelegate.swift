//
//  AppDelegate.swift
//  MapsFlickr
//
//  Created by Douglas Brito de Medeiros on 5/24/16.
//  Copyright © 2016 CodeNetworks. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.rootViewController = MapViewController()

        self.window = window
        self.window?.makeKeyAndVisible()

        return true
    }
}
