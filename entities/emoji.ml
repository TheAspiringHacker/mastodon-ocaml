type t = {
    shortcode : string;
    static_url : string;
    url : string;
    visible_in_picker : bool;
  } [@@deriving yojson]
