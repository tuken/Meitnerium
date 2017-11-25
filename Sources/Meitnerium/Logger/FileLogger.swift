import Foundation
import PerfectLib

public struct FileLogger: Logger {

    public var filename = "./FileLogger.log"
    
    public init(){}
    
    func filelog(priority: String, _ args: String, _ even: Bool) {
        let format = DateFormatter()
        format.locale = Locale(identifier: "ja_JP")
        format.timeStyle = .medium
        format.dateStyle = .medium

        let ff = File(self.filename)
        defer { ff.close() }
        do {
            try ff.open(.append)
            try ff.write(string: "\(priority) [\(format.string(from: Date()))] \(args)\n")
        }
        catch {
            ConsoleLogger().critical(message: "\(error)", even)
        }
    }
    
    public func debug(message: String, _ even: Bool) {
        filelog(priority: even ? "[DBG]" : "[DEBUG]", message, even)
    }
    
    public func info(message: String, _ even: Bool) {
        filelog(priority: even ? "[INFO] " : "[INFO]", message, even)
    }
    
    public func warning(message: String, _ even: Bool) {
        filelog(priority: even ? "[WARN] " : "[WARNING]", message, even)
    }
    
    public func error(message: String, _ even: Bool) {
        filelog(priority: even ? "[ERR]" : "[ERROR]", message, even)
    }
//    public func error(message: String, _ even: Bool, function: String = #function, line: Int = #line) {
//        filelog(priority: even ? "[ERR]" : "[ERROR]", "[\(function):\(line)]" + message, even)
//    }
    
    public func critical(message: String, _ even: Bool) {
        filelog(priority: even ? "[CRIT] " : "[CRITICAL]", message, even)
    }
    
    public func terminal(message: String, _ even: Bool) {
        filelog(priority: even ? "[TERM]" : "[TERMINAL]", message, even)
    }
}
