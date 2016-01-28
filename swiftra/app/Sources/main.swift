#if os(OSX)
    import Darwin
#elseif os(Linux)
    import Glibc
#endif

// Need this because output
// is not getting flushed properly
func debug(string: String) {
  print(string)
  fflush(stdout)
}

import swiftra

get("/") { req in
    debug("Yeeaaahhhhhhh")
    return "Hello, world!"
}

debug("Starting websever")
serve(8080)
