//
//  SignHandler.swift
//  Meitnerium
//
//  Created by 井川 司 on 2017/12/15.
//

import Foundation
import PerfectHTTP
import PerfectLib

public struct SignHandler {
    
    public static func `in`(req: HTTPRequest, res: HTTPResponse) {
        var acc: NewAccountTemp
        
        do {
            acc = try NewAccountTemp(req: req)
            let token = randomString()
            let expiry = Date(timeIntervalSinceNow: 86400)
            let data: [String:Any] = ["email" : acc.email, "password" : acc.password, "first_name" : acc.first_name, "last_name" : acc.last_name, "token" : token, "expiry" : formatter.string(from: expiry)]
            let res = try knex.insert(into: "account_temporaries", values: data)
            Log.info(message: "\(res)")
        }
        catch {
            Log.error(message: "\(error)")
            res.status = .badRequest
        }
        
        res.completed()
    }
}

