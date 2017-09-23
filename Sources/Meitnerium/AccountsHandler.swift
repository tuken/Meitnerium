//
//  AccountsHandler.swift
//  Meitnerium
//
//  Created by 井川司 on 2017/09/22.
//

import Foundation
import PerfectHTTP

public struct AccountsHandler {

    public static func list(_: HTTPRequest, res: HTTPResponse) {
        let accounts = try! knex.table("accounts").fetch()
        res.setBody(string: String(describing: accounts))
        res.completed()
    }
}
