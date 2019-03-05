module Type = struct
  type t =
    | Link
    | Photo
    | Video
    | Rich

  let of_string = function
    | "link" -> Ok Link
    | "photo" -> Ok Photo
    | "video" -> Ok Video
    | "rich" -> Ok Rich
    | str -> Error ("Invalid string: " ^ str)

  let to_string = function
    | Link -> "link"
    | Photo -> "photo"
    | Video -> "video"
    | Rich -> "rich"

  let of_yojson = function
    | `String str -> of_string str
    | _ -> Error "Type.t is not a string"

  let to_yojson t = `String (to_string t)
end

type t = {
    url : string;
    title : string;
    description : string;
    image : string option;
    typ : Type.t; [@key "type"]
    author_name : string option;
    author_url : string option;
    provider_name : string option;
    provider_url : string option;
    html : string option;
    width : int option; (* Should these be ints or floats? *)
    height : int option;
    embed_url : string option [@default None];
      (** This field does not appear in the Mastodon API documentation, but it
          appears in responses. *)
  } [@@deriving yojson]
