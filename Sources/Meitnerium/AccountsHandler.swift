//
//  AccountsHandler.swift
//  Meitnerium
//
//  Created by 井川司 on 2017/09/22.
//

import Foundation
import PerfectHTTP

public struct AccountsHandler {

    public static func list(data: [String:Any]) throws -> RequestHandler {
        return {
            req, res in
            res.completed()
        }
    }

    public static func show(data: [String:Any]) throws -> RequestHandler {
        return {
            req, res in
            res.completed()
        }
    }
}
