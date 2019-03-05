module Field = struct
  type t = {
      name : string;
      value : string;
      verified_at : string option;
    } [@@deriving yojson]
end

type t = {
    id : string;
    username : string;
    acct : string;
    display_name : string;
    locked : bool;
    created_at : string;
    followers_count : int;
    following_count : int;
    statuses_count : int;
    note : string;
    url : string;
    avatar : string;
    avatar_static : string;
    header : string;
    header_static : string;
    fields : Field.t list option;
    bot : bool option;
    emojis : Emoji.t list
  } [@@deriving yojson]
