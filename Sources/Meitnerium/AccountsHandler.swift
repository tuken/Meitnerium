//
//  AccountsHandler.swift
//  Meitnerium
//
//  Created by 井川司 on 2017/09/22.
//

import Foundation
import PerfectHTTP
import PerfectLib
import Validation

struct tempModel {
    
    var email: String = ""
    
    var password: String = ""
    
    init(req: HTTPRequest) throws {
        guard let body = req.postBodyString, let json = try? body.jsonDecode(), let jobj = json as? Dictionary<String, Any> else {
            Log.error(message: "no json in http request: {\(String(describing: req.postBodyString))}")
            throw SecualError.noJsonObject
        }

        guard let email = jobj["email"] as? String else {
            throw SecualError.noParameter("email")
        }
        
        try EmailValidator().validate(email)
        self.email = email

        guard let password = jobj["password"] as? String, let confirm_password = jobj["confirm_password"] as? String else {
            throw SecualError.noParameter("password")
        }
        
        let passwd = Equals<String>(confirm_password)
        try passwd.validate(password)
        self.password = password
    }
}

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
        var modl: tempModel
        
        do {
            try modl = tempModel(req: req)
        }
        catch {
            Log.error(message: "\(error)")
            res.status = .badRequest
        }
        
        res.completed()
    }
}
