module Visibility = struct
  type t =
    | Public
    | Unlisted
    | Private
    | Direct

  let of_string = function
    | "public" -> Ok Public
    | "unlisted" -> Ok Unlisted
    | "private" -> Ok Private
    | "direct" -> Ok Direct
    | str -> Error ("Invalid visibility: " ^ str)

  let of_yojson = function
    | `String str -> of_string str
    | _ -> Error "Visibility.t is not a string"
end

type t = {
    id : string;
    uri : string;
    url : string option;
    account : Account.t;
    in_reply_to_id : string option;
    in_reply_to_account_id : string option;
    reblog : t option;
    content : string;
    created_at : string;
    emojis : Emoji.t list;
    replies_count : int;
    reblogs_count : int;
    favourites_count : int;
    reblogged : (bool option [@default None]);
    favourited: (bool option [@default None]);
    muted : (bool option [@default None]);
    sensitive : bool;
    spoiler_text : string;
    visibility : string;
    card : Card.t option;
    language : string option;
    pinned : bool option [@default None];
  } [@@deriving yojson { strict = false }]
