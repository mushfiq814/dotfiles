;; extends

(
  ([
    (list_marker_star)
    (list_marker_plus)
    (list_marker_minus)
  ]) @markdown_list_marker
  ; (#set! conceal "・"))
  (#set! conceal "樂")
  ; (#set! conceal "雷")
  ; (#set! conceal "栗")
  ; (#set! conceal "六")
  ; (#set! conceal "縷")
  ; (#set! conceal "錄")
  ; (#set! conceal "論")
  ; (#set! conceal "籠")
  ; (#set! conceal "怜")
  ; (#set! conceal "淪")
  ; (#set! conceal "嬨")
  ; (#set! conceal "懲")
  ; (#set! conceal "窱")
  ; (#set! conceal "絛")
)

((task_list_marker_unchecked) @markdown_check (#set! conceal ""))
((task_list_marker_checked) @markdown_check (#set! conceal ""))
