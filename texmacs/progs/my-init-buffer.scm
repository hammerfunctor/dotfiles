(if (not (buffer-has-name? (current-buffer)))
    (begin
      (buffer-pretend-saved (current-buffer))
      ;; style and packages
      (init-style "mynotes")

      ))

;;(init-page-rendering "papyrus")
