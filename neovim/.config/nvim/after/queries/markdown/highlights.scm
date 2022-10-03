([
  (list_marker_star)
  (list_marker_plus)
  (list_marker_minus)
] @conceal
(#set! conceal "・"))

((task_list_marker_unchecked) @conceal (#set! conceal ""))
((task_list_marker_checked) @conceal (#set! conceal ""))

; to conceal the list markers as well but this will
; disable markers for all lists; not just checkbox lists
; (list_item [
;   (list_marker_plus)
;   (list_marker_minus)
;   (list_marker_star)
;   (list_marker_dot)
;   (list_marker_parenthesis)
; ] @conceal [
;     (task_list_marker_checked)
;     (task_list_marker_unchecked)
; ](#set! conceal ""))
