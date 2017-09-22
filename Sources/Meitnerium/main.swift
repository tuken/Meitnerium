import PerfectHTTPServer
import PerfectLib

var logger = FileLogger()
logger.filename = "/Users/tsukasa.ikawa/Meitnerium.log"
Log.logger = logger

do {
    try HTTPServer.launch(configurationPath: "/Users/tsukasa.ikawa/Meitnerium.json")
}
catch {
    Log.error(message: "cannot launch HTTPServer: \(error)")
}
