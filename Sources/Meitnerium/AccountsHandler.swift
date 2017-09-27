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
            do {
                let json = try accounts.jsonEncodedString()
                res.setBody(string: json)
            }
            catch {
                Log.error(message: "cannot encode json: \(error)")
                res.status = .internalServerError
            }
        }
        
        res.completed()
    }
    
    public static func temp(req: HTTPRequest, res: HTTPResponse) {
        if let body = req.postBodyString, let json = try? body.jsonDecode(), let jobj = json as? Dictionary<String, Any> {
        }
        else {
            res.status = .badRequest
        }
        
        res.completed()
    }
}
