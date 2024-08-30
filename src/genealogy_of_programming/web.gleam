import wisp.{type Request, type Response}

/// The middleware stack that the request handler uses.
pub fn middleware(
  req: Request,
  handle_request: fn(Request) -> Response,
) -> Response {
  // Permit browsers to simulate methods other than GET and POST using the
  // `_method` query parameter.
  let req = wisp.method_override(req)
  use <- wisp.log_request(req)
  use <- wisp.rescue_crashes
  use req <- wisp.handle_head(req)

  // Handle the request!
  handle_request(req)
}
