open Entities

let urls =
  [ "https://functional.cafe/api/v1/accounts/1"
  ; "https://mastodon.social/api/v1/accounts/1" ]

let () =
  List.iter (fun url ->
      ignore (Test_common.test Account.of_yojson "Account test failed" url)
    ) urls
