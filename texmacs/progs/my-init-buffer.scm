(if (not (buffer-has-name? (current-buffer)))
  (begin
    ;; style and packages
    (init-style "mynotes")
    
    (buffer-pretend-saved (current-buffer))))
