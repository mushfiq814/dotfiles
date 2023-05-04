;; extends

([
  (list_marker_star)
  (list_marker_plus)
  (list_marker_minus)
] @conceal
(#set! conceal "・"))

((task_list_marker_unchecked) @conceal (#set! conceal ""))
((task_list_marker_checked) @conceal (#set! conceal ""))
