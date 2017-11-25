//
//  RequestModel.swift
//  Meitnerium
//
//  Created by 井川司 on 2017/11/25.
//

import Foundation
import PerfectHTTP
import PerfectLib

protocol Insertable {
    
    func asInsertData() -> [String:Any]
}

class RequestModel: Insertable {
    
    var jsonObj: Dictionary<String, Any> = [:]
    
    init(req: HTTPRequest) throws {
        guard let body = req.postBodyString, let json = try? body.jsonDecode(), let jobj = json as? Dictionary<String, Any> else { throw SecualError.noJsonObject(String(describing: req.postBodyString)) }
        
        self.jsonObj = jobj
    }

    func asInsertData() -> [String : Any] {
        fatalError("need to override!")
    }
}
