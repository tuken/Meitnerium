import Foundation
import PerfectHTTPServer
import PerfectLib
import PerfectHTTP
import SwiftKnex

enum SecualError: Error {
    case noJsonObject(String)
    case noParameter(String)
    case invalidFormat(String)
    case invalidValue(String)
}

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
routes.add(method: .get, uri: "/v2/list", handler: AccountsHandler.list)
routes.add(method: .post, uri: "/v2/temp", handler: AccountsHandler.temp)

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
