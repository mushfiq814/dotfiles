;; extends
(
  (shortcut_link (link_text) @linkTxt (#eq? @linkTxt "<")) @conceal
  (#set! conceal "")
)
(
  (shortcut_link (link_text) @linkTxt (#eq? @linkTxt ">")) @conceal
  (#set! conceal "")
)
(
  (strikethrough) @puntuation.strikethrough
)
