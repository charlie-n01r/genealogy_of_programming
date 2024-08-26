import genealogy_of_programming/web
import gleam/string_builder
import wisp.{type Request, type Response}

/// The HTTP request handler
pub fn handle_request(req: Request) -> Response {
  // Apply the middleware stack for this request/response.
  use _req <- web.middleware(req)
  let response =
    string_builder.from_string("{\"id\": 0, \"name\": \"Assembly\"}")

  // Return a 200 OK response with the body and a json content type.
  wisp.json_response(response, 200)
}
