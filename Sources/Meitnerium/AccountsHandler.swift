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
import Validation

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
        guard let body = req.postBodyString, let json = try? body.jsonDecode(), let jobj = json as? Dictionary<String, Any> else {
            Log.error(message: "no parameter: ")
            res.completed(status: .badRequest)
            return
        }

        do {
            guard let email = jobj["email"] as? String else {
                throw SecualError.noParameter
            }
            try EmailValidator().validate(email)
        }
        catch {
            Log.error(message: "invalid parameter: \(error)")
            res.status = .internalServerError
        }
        
        res.completed()
    }
}
