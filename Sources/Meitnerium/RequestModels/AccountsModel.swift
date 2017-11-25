//
//  AccountsHandler.swift
//  Meitnerium
//
//  Created by 井川司 on 2017/09/22.
//

import Foundation
import PerfectHTTP
import PerfectLib

struct NewAccount {
    
    var email: String = ""
    
    var password: String = ""
    
    init(req: HTTPRequest) throws {
        guard let body = req.postBodyString, let json = try? body.jsonDecode(), let jobj = json as? Dictionary<String, Any> else { throw SecualError.noJsonObject(String(describing: req.postBodyString)) }
        guard let email = jobj["email"] as? String else { throw SecualError.noParameter("email") }
        guard email.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: .regularExpression, range: nil, locale: nil) != nil else { throw SecualError.invalidFormat("invalid email format") }
        guard let password = jobj["password"] as? String, let confirm_password = jobj["confirm_password"] as? String else { throw SecualError.noParameter("password") }
        guard password.range(of: "[A-Z0-9a-z!.-=@<>]{8,16}", options: .regularExpression, range: nil, locale: nil) != nil else { throw SecualError.invalidFormat("invalid password format") }
        guard password == confirm_password else { throw SecualError.invalidValue("different two password") }

        self.email = email
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
        var modl: NewAccount
        
        do {
            try modl = NewAccount(req: req)
        }
        catch {
            Log.error(message: "\(error)")
            res.status = .badRequest
        }
        
        res.completed()
    }
}
