module URLs = struct
  type t = {
      streaming_api : string;
    } [@@deriving yojson]
end

module Stats = struct
  type t = {
      user_count : int;
      status_count : int;
      domain_count : int;
    } [@@deriving yojson]
end

type t = {
    uri : string;
    title : string;
    description : string;
    email : string;
    version : string;
    thumbnail : string option;
    urls : URLs.t;
    stats : Stats.t;
    languages : string list;
    contact_account : Account.t option;
  } [@@deriving yojson { strict = false }]
(* The response body contains a Boolean [registrations] field that is
   undocumented in the Mastodon API docs. *)
