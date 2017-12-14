//
//  main.swift
//  Meitnerium
//
//  Created by 井川司 on 2017/09/22.
//

import Foundation
import PerfectHTTPServer
import PerfectLib
import PerfectHTTP
import SwiftKnex

func randomString() -> String {
    var array = [UInt8](repeating: 0, count: 10)
    
    let fd = open("/dev/urandom", O_RDONLY)
    if fd != -1 {
        read(fd, &array, MemoryLayout.size(ofValue: array) * array.count)
        close(fd)
        
        let data = Data(array)
        return data.base64EncodedString()
            .replacingOccurrences(of: "/", with: "a")
            .replacingOccurrences(of: "+", with: "z")
            .replacingOccurrences(of: "=", with: "-")
    }
    
    return UUID().string
}

let formatter = DateFormatter()
formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
formatter.locale = Locale(identifier: "ja_JP")

var logger = FileLogger()
logger.filename = "/Users/tsukasa.ikawa/Meitnerium.log"
Log.logger = logger

let config = KnexConfig(host: "localhost", user: "root", password: "secualpass", database: "secual", isShowSQLLog: true)
let con = try! KnexConnection(config: config)
let knex = con.knex()

var routes = Routes()
routes.add(method: .post, uri: "/v2/signin", handler: SignHandler.in)
routes.add(method: .get, uri: "/v2/accounts", handler: AccountsHandler.list)
routes.add(method: .post, uri: "/v2/signup", handler: AccountsHandler.new)

let server = HTTPServer()
server.serverName = "localhost"
server.serverPort = 8080
server.addRoutes(routes)

do {
//    try HTTPServer.launch(configurationPath: "/Users/tsukasa/Meitnerium.json")
    try server.start()
}
catch {
    Log.error(message: "cannot launch HTTPServer: \(error)")
}
