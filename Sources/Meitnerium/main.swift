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
    case openRandom(Int32)
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
logger.filename = "/Users/tsukasa/Meitnerium.log"
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
