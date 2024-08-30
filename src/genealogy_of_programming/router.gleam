import genealogy_of_programming/web
import gleam/http.{Get}
import gleam/string_builder
import wisp.{type Request, type Response}

/// The HTTP request handler
pub fn handle_request(req: Request) -> Response {
  // Apply the middleware stack for this request/response.
  use req <- web.middleware(req)

  // Forward the request to different paths
  case wisp.path_segments(req) {
    [] -> home_page(req)
    ["languages"] -> language_tree(req)
    ["languages", id] -> language_detail(id, req)
    _ -> wisp.not_found()
  }
}

fn home_page(req: Request) -> Response {
  // The page can only be accessed via GET requests, so this middleware is
  // used to return a 405: Method Not Allowed response for all other methods.
  use <- wisp.require_method(req, Get)
  let html =
    string_builder.from_string("<h1>Genealogy of programming languages!</h1>")
  wisp.ok()
  |> wisp.html_body(html)
}

fn language_tree(req: Request) -> Response {
  use <- wisp.require_method(req, Get)
  let html = string_builder.from_string("Language tree under construction!")
  wisp.ok()
  |> wisp.html_body(html)
}

fn language_detail(id: String, req: Request) -> Response {
  use <- wisp.require_method(req, Get)
  // Return a json response depending on the id received
  case id {
    "0" -> {
      string_builder.from_string("{\"id\":" <> id <> ",\"name\": \"Assembly\"}")
      |> wisp.json_response(200)
    }
    "1" -> {
      string_builder.from_string("{\"id\":" <> id <> ",\"name\": \"C\"}")
      |> wisp.json_response(200)
    }
    _ -> wisp.not_found()
  }
}
