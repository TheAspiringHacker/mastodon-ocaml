open Entities

let urls =
  [ "https://functional.cafe/api/v1/instance"
  ; "https://mastodon.social/api/v1/instance" ]

let () =
  List.iter (fun url ->
      ignore (Test_common.test Instance.of_yojson "Instance test failed" url)
    ) urls
