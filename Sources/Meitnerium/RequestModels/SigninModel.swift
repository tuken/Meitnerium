//
//  SigninModel.swift
//  Meitnerium
//
//  Created by 井川 司 on 2017/12/15.
//

import Foundation
import PerfectHTTP
import PerfectLib
import SwiftKnex

class Signin: RequestModel {
    
    var email: String = ""
    
    var password: String = ""
    
    var fcm_token: String? = nil
    
    var user_agent: UInt? = nil
    
    override init(req: HTTPRequest) throws {
        try super.init(req: req)
        
        guard let email = jsonObj["email"] as? String else { throw SecualError.noParameter("email") }
        guard email.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: .regularExpression, range: nil, locale: nil) != nil else { throw SecualError.invalidFormat("invalid email format") }
        guard let password = jsonObj["password"] as? String else { throw SecualError.noParameter("password") }
        
        self.email = email
        self.password = password
        self.fcm_token = jsonObj["fcm_toke"] as? String
        self.user_agent = (jsonObj["user_agent"] as? Int).map { UInt($0) }
    }
}

