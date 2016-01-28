#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif
import HTTP
import Router
import Epoch
import CHTTPParser
import CLibvenice

// Need this because output
// is not getting flushed properly
func debug(string: String) {
  print(string)
  fflush(stdout)
}

let router = Router { router in
    router.get("/") { request in
        // do something based on the Request
        debug("Yeeaaahhhhhhh")
        return Response(status: .OK, json: ["Hello": "World"])
    }
}

debug("Starting websever")
let server = Server(port: 8080, responder: router)
server.start()
