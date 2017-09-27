//
//  AccountsHandler.swift
//  Meitnerium
//
//  Created by 井川司 on 2017/09/22.
//

import Foundation
import PerfectHTTP
import PerfectLib
import SwiftyJSON

public struct AccountsHandler {

    public static func list(_: HTTPRequest, res: HTTPResponse) {
        let results = try! knex.table("accounts").fetch()
        if let accounts = results {
            Log.debug(message: "json: \(accounts)")
//            do {
//                let json = JSON(data: accounts as Data)
//                //res.setBody(string: json.description)
//            }
//            catch {
//                Log.error(message: "cannot encode json: \(error)")
//            }
//            let jobj = JSON(data: accounts. as Data)
            do {
                let json = try accounts.jsonEncodedString()
                res.setBody(string: json)
            }
            catch {
                Log.error(message: "cannot encode json: \(error)")
            }
        }
        
        res.completed()
    }
}
