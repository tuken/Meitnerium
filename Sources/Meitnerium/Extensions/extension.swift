//
//  extension.swift
//  Meitnerium
//
//  Created by 井川司 on 2017/11/29.
//

import Foundation
import PerfectLib

extension Int8: JSONConvertible {
    public func jsonEncodedString() throws -> String {
        return String(self)
    }
}

extension Int16: JSONConvertible {
    public func jsonEncodedString() throws -> String {
        return String(self)
    }
}

extension UInt8: JSONConvertible {
    public func jsonEncodedString() throws -> String {
        return String(self)
    }
}

extension UInt16: JSONConvertible {
    public func jsonEncodedString() throws -> String {
        return String(self)
    }
}

extension NSNull: JSONConvertible {
    public func jsonEncodedString() throws -> String {
        return "null"
    }
}

extension Date: JSONConvertible {
    public func jsonEncodedString() throws -> String {
        return "\"\(self.description)\""
    }
}
