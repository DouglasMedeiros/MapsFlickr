//
//  APIManager.swift
//  MapsFlickr
//
//  Created by Douglas Brito de Medeiros on 5/24/16.
//  Copyright © 2016 CodeNetworks. All rights reserved.
//

import Alamofire
import ObjectMapper
import AlamofireNetworkActivityIndicator

class APIManager {

    static let sharedInstance = APIManager()

    var manager: Alamofire.Manager

    init() {
        NetworkActivityIndicatorManager.sharedManager.isEnabled = true

        let memoryCapacity = 500 * 1024 * 1024
        let diskCapacity = 500 * 1024 * 1024
        let cache = NSURLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "Cache-01")

        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let defaultHeaders = Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]

        configuration.HTTPAdditionalHeaders = defaultHeaders
        configuration.requestCachePolicy = .UseProtocolCachePolicy
        configuration.URLCache = cache

        let baseAPIURL: NSURL = NSURL(string: Constants.Config.Flickr.Host)!

        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            baseAPIURL.host!: .DisableEvaluation
        ]

        let serverTrustPolicyManager = ServerTrustPolicyManager(policies: serverTrustPolicies)

        self.manager = Alamofire.Manager(configuration: configuration, serverTrustPolicyManager: serverTrustPolicyManager)
    }

}
