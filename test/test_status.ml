open Entities

let urls =
  [ "https://functional.cafe/api/v1/accounts/1/statuses"
  ; "https://mastodon.social/api/v1/accounts/1/statuses" ]

let () =
  List.iter (fun url ->
      ignore
        (Test_common.test_list Status.of_yojson "Status test failed" url)
    ) urls
