import Foundation
import PerfectHTTPServer
import PerfectLib
import PerfectHTTP
import SwiftKnex

extension Int8: JSONConvertible {
    public func jsonEncodedString() throws -> String {
        return String(self)
    }
}

extension Int16: JSONConvertible {
    public func jsonEncodedString() throws -> String {
        return String(self)
    }
}

extension UInt8: JSONConvertible {
    public func jsonEncodedString() throws -> String {
        return String(self)
    }
}

extension UInt16: JSONConvertible {
    public func jsonEncodedString() throws -> String {
        return String(self)
    }
}

extension NSNull: JSONConvertible {
    public func jsonEncodedString() throws -> String {
        return "null"
    }
}

extension Date: JSONConvertible {
    public func jsonEncodedString() throws -> String {
        return "\"\(self.description)\""
    }
}

var logger = FileLogger()
logger.filename = "/Users/tsukasa.ikawa/Meitnerium.log"
Log.logger = logger

let config = KnexConfig(host: "localhost", user: "root", password: "secualpass", database: "secual", isShowSQLLog: true)
let con = try! KnexConnection(config: config)
let knex = con.knex()

var routes = Routes()
routes.add(method: .get, uri: "/v2/zip", handler: AccountsHandler.list)

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
