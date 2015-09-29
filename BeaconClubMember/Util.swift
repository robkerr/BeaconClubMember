//
//  Utilities.swift
//  UserApp
//
//  Created by Rob Kerr on 5/10/15
//  Copyright (c) 2015 Mobile Toolworks, LLC. All rights reserved.
//

import Foundation

public enum AppLogLevel {
    case None, Verbose
}

public var _logLevel : AppLogLevel = .Verbose

extension String {
    static func className(aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).componentsSeparatedByString(".").last!
    }
}

public struct Util {
    
    static func log(message: String?) {
        if _logLevel == .Verbose {
            if let s = message {
                println(message)
            }
        }
    }
    
}