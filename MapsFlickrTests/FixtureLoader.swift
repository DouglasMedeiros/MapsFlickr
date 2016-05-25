//
//  Loader.swift
//  CicloRidersTests
//
//  Created by Thiago Lioy on 2/7/16.
//  Updated by Douglas Brito de Medeiros on 2/16/16.
//  Copyright © 2016 CodeNetworks. All rights reserved.
//

import Foundation

public enum FixtureLoaderError: ErrorType{
    case InvalidPath
    case ParseError
}

struct FixtureLoader {

    static func data(fromfile file: String) throws -> NSData? {
        let bundle = NSBundle(forClass: AppDelegateTests.self)

        guard let path = bundle.pathForResource(file, ofType: "json") else {
            throw FixtureLoaderError.InvalidPath
        }

        let pathUrl = NSURL(fileURLWithPath: path)
        do {
            return try NSData(contentsOfURL: pathUrl, options: NSDataReadingOptions.DataReadingMappedIfSafe)
        } catch {
            throw FixtureLoaderError.ParseError
        }
    }
}
