//
//  Fixture.swift
//  CicloRidersTests
//
//  Created by Douglas Brito de Medeiros on 2/16/16.
//  Copyright © 2016 CodeNetworks. All rights reserved.
//

import Foundation
import ObjectMapper

public struct Fixture {
    let filename: String

    public init(_ name: String) {
        filename = name
    }

    public func toString() throws -> String? {
        let data = try FixtureLoader.data(fromfile: self.filename)
        return String(data: data!, encoding: NSUTF8StringEncoding)
    }

    public func mapTo<T: Mappable>(type: T.Type) throws -> T? {
        let jsonString = try self.toString()
        let result = Mapper<T>().map(jsonString!)
        return result
    }
}
