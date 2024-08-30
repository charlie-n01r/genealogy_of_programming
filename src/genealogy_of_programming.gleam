import dot_env
import dot_env/env
import genealogy_of_programming/router
import gleam/erlang/process
import mist
import wisp
import wisp/wisp_mist

pub fn main() {
  // Set logging information and fetch secret key from .env file
  wisp.configure_logger()

  dot_env.new()
  |> dot_env.set_path(".env")
  |> dot_env.set_debug(False)
  |> dot_env.load

  let assert Ok(secret_key_base) = env.get_string("SECRET_KEY_BASE")

  // Start the Mist web server.
  let assert Ok(_) =
    wisp_mist.handler(router.handle_request, secret_key_base)
    |> mist.new
    |> mist.port(8000)
    |> mist.start_http

  // Put current process to sleep
  process.sleep_forever()
}
