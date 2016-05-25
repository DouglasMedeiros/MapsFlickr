//
//  Request.swift
//
//  Created by Daniel Clelland on 10/12/15.
//  Updated by Douglas Brito de Medeiros on 01/11/15.
//  Copyright © 2015 Daniel Clelland. All rights reserved.
//

import Alamofire

// MARK: - AlamofireLogger extension
extension Request {
    /**
     The logging level. `Simple` prints only a brief request/response description; `Verbose` prints the request/response body as well.

     - Simple:  Simple level
     - Verbose: Verbose level
     */
    public enum LogLevel {
        case Simple
        case Verbose
    }

    /**
     Log the request and response at the specified `level`.

     - parameter level: Level mode

     - returns: Self
     */
    public func log(level level: LogLevel = .Simple) -> Self {
        switch level {
        case .Simple:
            return logRequest(level: .Simple).logResponse(level: .Simple)
        case .Verbose:
            return logRequest(level: .Verbose).logResponse(level: .Verbose)
        }
    }

    /**
     Enum Request log level

     - Simple:  Simple level
     - Verbose: Verbose level
     */
    public enum RequestLogLevel {
        case Simple
        case Verbose
    }

    /**
     Log the request at the specified `level`.

     - parameter level: Log level

     - returns: Self
     */
    public func logRequest(level level: RequestLogLevel = .Simple) -> Self {
        guard let request = request else {
            return self
        }

        guard let method = request.HTTPMethod, let path = request.URL?.absoluteString else {
            return self
        }

        if let data = request.HTTPBody, body = NSString(data: data, encoding: NSUTF8StringEncoding) where level == .Verbose {
            print("\(method) \(path): \"\(body)\"")
        } else {
            print("\(method) \(path)")
        }

        return self
    }

    /**
     The response logging level. `Simple` prints only the HTTP status code and path; `Verbose` prints the response body as well.

     - Simple:  Simple level
     - Verbose: Verbose level
     */
    public enum ResponseLogLevel {
        case Simple
        case Verbose
    }

    /**
     Log the response at the specified `level`.

     - parameter level: Log level

     - returns: Self
     */
    public func logResponse(level level: ResponseLogLevel = .Simple) -> Self {
        response { request, response, data, error in

            guard let response = response else {
                if let method = request?.URLRequest.HTTPMethod,
                    path = request?.URL?.absoluteString,
                    description = error?.localizedDescription,
                    data = data,
                    body = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    print("\(method) \(path): \"\(description)\" response: \(body)")
                }
                return
            }

            guard let path = response.URL?.absoluteString else {
                return
            }

            if let data = data, body = NSString(data: data, encoding: NSUTF8StringEncoding) where level == .Verbose {
                print("\(response.statusCode) \(path): \"\(body)\"")
            } else {
                print("\(response.statusCode) \(path)")
            }
        }
        
        return self
    }
}
