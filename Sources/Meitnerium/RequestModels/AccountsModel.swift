//
//  AccountsModel.swift
//  Meitnerium
//
//  Created by 井川司 on 2017/09/22.
//

import Foundation
import PerfectHTTP
import PerfectLib
import SwiftKnex

class NewAccountTemp: RequestModel {
    
    var email: String = ""
    
    var password: String = ""
    
    var first_name: String = ""
    
    var last_name: String = ""
    
    var zip: String? = nil
    
    var address: String? = nil
    
    var tel: String? = nil
    
    var mobile_tel: String? = nil

    override init(req: HTTPRequest) throws {
        try super.init(req: req)
        
        guard let email = jsonObj["email"] as? String else { throw SecualError.noParameter("email") }
        guard email.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: .regularExpression, range: nil, locale: nil) != nil else { throw SecualError.invalidFormat("invalid email format") }
        guard let password = jsonObj["password"] as? String, let confirm_password = jsonObj["confirm_password"] as? String else { throw SecualError.noParameter("password") }
        guard password.range(of: "[A-Z0-9a-z!.-=@<>]{8,16}", options: .regularExpression, range: nil, locale: nil) != nil else { throw SecualError.invalidFormat("invalid password format") }
        guard password == confirm_password else { throw SecualError.invalidValue("different two password") }
        guard let first_name = jsonObj["first_name"] as? String else { throw SecualError.noParameter("first_name")  }
        guard let last_name = jsonObj["last_name"] as? String else { throw SecualError.noParameter("last_name")  }

        self.email = email
        self.password = password
        self.first_name = first_name
        self.last_name = last_name
        self.zip = jsonObj["zip"] as? String
        self.address = jsonObj["address"] as? String
        self.tel = jsonObj["tel"] as? String
        self.mobile_tel = jsonObj["mobile_tel"] as? String
    }
    
    override func asInsertData() -> [String:Any] {
        let token = randomString()
        let expiry = Date(timeIntervalSinceNow: 86400)
        var data: [String:Any] = ["email":self.email, "password":self.password, "first_name":self.first_name, "last_name":self.last_name, "token":token, "expiry":formatter.string(from: expiry)]
        
        if let zip = self.zip {
            data["zip"] = zip
        }
        
        if let address = self.address {
            data["address"] = address
        }
        
        if let tel = self.tel {
            data["tel"] = tel
        }
        
        if let mobile_tel = self.mobile_tel {
            data["mobile_tel"] = mobile_tel
        }
        
        return data
    }
}

