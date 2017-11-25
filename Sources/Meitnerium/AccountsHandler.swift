//
//  AccountsHandler.swift
//  Meitnerium
//
//  Created by 井川司 on 2017/09/22.
//

import Foundation
import PerfectHTTP
import PerfectLib

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
    
    public static func new(req: HTTPRequest, res: HTTPResponse) {
        var acc: NewAccount
        
        do {
            try acc = NewAccount(req: req)
            let res = try knex.insert(into: "accounts", values: acc.asInsertData())
            Log.info(message: "\(res)")
        }
        catch {
            Log.error(message: "\(error)")
            res.status = .badRequest
        }
        
        res.completed()
    }
}
