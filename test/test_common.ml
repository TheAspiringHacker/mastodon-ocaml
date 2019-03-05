open Lwt
open Cohttp
open Cohttp_lwt_unix

let monad url =
  Uri.of_string url |> Client.get >>= fun (resp, body) ->
  Cohttp_lwt.Body.to_string body >|= fun string ->
  (resp, string)

let handle_error resp body =
  let code = Code.code_of_status (Response.status resp) in
  print_endline ("Response code: " ^ string_of_int code);
  print_endline ("Headers: " ^ (resp |> Response.headers |> Header.to_string));
  print_endline body

let test f err_msg url =
  let resp, body = monad url |> Lwt_main.run in
  let json = Yojson.Safe.from_string body in
  match f (Yojson.Safe.from_string body) with
  | Ok a -> a
  | exception Yojson.Json_error e ->
     print_endline e;
     handle_error resp body;
     failwith "Yojson parse failed"
  | Error e ->
     print_endline e;
     handle_error resp body;
     print_endline (Yojson.Safe.pretty_to_string json);
     failwith err_msg

let test_list f err_msg url =
  let resp, body = monad url |> Lwt_main.run in
  let json = Yojson.Safe.from_string body in
  match json with
  | `List list ->
     List.fold_right (fun json acc ->
         match f json with
         | Ok a -> a::acc
         | Error e ->
            print_endline e;
            handle_error resp body;
            print_endline (Yojson.Safe.pretty_to_string json);
            failwith err_msg
       ) list []
  | _ ->
     handle_error resp body;
     failwith "Not a list"
