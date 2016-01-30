#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif

import Foundation

import Core
import HTTP
import Router
import Epoch
import CHTTPParser
import CLibvenice

import PostgreSQL

// Need this because output
// is not getting flushed properly
func debug(items: Any...) {
  debugPrint(items)
  fflush(stdout)
}

// let processInfo = NSProcessInfo()
let processInfo = NSProcessInfo.processInfo()
let env = processInfo.environment
debug("Env: \(env)")

let info = Connection.Info(host: "epochdb", database: "postgres", port: 5432, user: "postgres", password: nil)
let conn = Connection(info)

do {
  try conn.open()
  try EpochMigrations.up(conn)
} catch {
    // debug(error)
}
debug("Conn status: \(conn.status)")

let router = Router { router in
  router.get("/") { request in

    let results = try conn.execute("SELECT * FROM users")
    // debug(results)
    let json: [Any] = results.flatMap { result -> [String: Any]? in
        guard let id = result["id"]?.string, name = result["name"]?.string else {
          return nil
        }
        return ["id": id, "name": name]
      }

    return Response(status: .OK, json: Core.JSON.from(json))
  }
}

debug("Starting websever")
let server = Server(port: 8080, responder: router)
server.start()
