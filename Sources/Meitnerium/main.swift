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

var logger = FileLogger()
logger.filename = "/Users/tsukasa.ikawa/Meitnerium.log"
Log.logger = logger

let config = KnexConfig(host: "localhost", user: "root", password: "secualpass", database: "secual", isShowSQLLog: true)
let con = try! KnexConnection(config: config)
let knex = con.knex()

var routes = Routes()
routes.add(method: .get, uri: "/v2/list", handler: AccountsHandler.list)
routes.add(method: .post, uri: "/v2/new", handler: AccountsHandler.new)

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
