
(use-modules (dynamic session-edit))
(set-session-multiline-input "python" "default" #t)
(set-session-multiline-input "scheme" "default" #t)
(set-session-multiline-input "julia" "default" #t)
(set-session-multiline-input "mma" "default" #t)
(set-session-multiline-input "gnuplot" "default" #t)
(set-session-multiline-input "graph" "default" #t)



;;(use-modules (texmacs menus main-menu))
;; I don't know how to add a new item to the `texmacs-menu'
;;(tm-menu (my-menu)
;;  (-> "Opening"
;;      ("Dear Sir" (insert "Dear Sir,"))
;;      ("Dear Madam" (insert "Dear Madam,")))
;;  (-> "Closing"
;;      ("Yours sincerely" (insert "Yours sincerely,"))
;;      ("Greetings" (insert "Greetings."))))

;; To define new menus, you have to evaluate it first.
;; They are `lazy-define'd, which is not covered in the doc.
;;(developer-menu)
;;(menu-bind developer-menu
;;  (group "User defined") (link my-menu)
;;  ---
;;  (former))

(define (image? t) (tree-is? t 'image))
(define (find-image t)
  (car (tree-search (tree-outer t) image?)))
(define (set-image-size t size)
  (tree-set! t 1 (string->tree size)))

(kbd-map
 ;; general
 ;; for macOS, `M-L` doesn't work, it's `load`, `C-L` and `A-L` work
 ;; for Linux, `C-L` doesn't work, it's also `load`, `A-L`, `M-L` work
 ;;("C-V"                      (clipboard-paste-import "verbatim" "primary"))
 ;;("C-L"                      (clipboard-paste-import "latex" "primary"))
 ("A-V" (clipboard-paste-import "verbatim" "primary"))
 ("A-L" (clipboard-paste-import "latex" "primary"))
 ("A-C-L" (clipboard-copy-export "latex" "primary"))
 ("A-G" (set-image-size (find-image (cursor-tree)) "0.318par"))
;; ("M-x" (insert "This is Meta-X"))
;; ("A-x" (insert "This is Alt-X"))
;; ("C-l" (insert "This is Ctrl-l"))

 ("M-E p" (my/export-to-pdf))

 ;; dices
 ("@ tab 1" "<#2680>")
 ("@ tab 2" "<#2681>")
 ("@ tab 3" "<#2682>")
 ("@ tab 4" "<#2683>")
 ("@ tab 5" "<#2684>")
 ("@ tab 6" "<#2685>")
 )

(kbd-map
 (:mode in-math?)
 ;; ========== double letters
 ("s s" (insert '(concat (big "sum") (rsub "k"))))
 ;; ("i i" (make-big-operator "int"))
 ("i i" (insert '(concat (big "int") (rsub "a") (rsup "b"))))
 ("p p" (insert '(concat (big "prod") (rsub "k"))))
 ("m m" (make 'matrix))
 ("f f" (make 'frac))
 ("r r" (make 'sqrt))
 ("^ ^" (make-wide "^"))
 ("d d" (insert '(wide "x" "<dot>")))
 ;; ("d d" (make-wide "<dot>"))
 ("v v" (make-wide "<vect>"))
 ("u u" (insert-go-to '(below (wide* "" "<wide-underbrace>") "x") '(0 0 0)))

 ;; ========== others
 ("d e l" (insert "<nabla>"))
 )

(kbd-map
  (:mode in-text?)

  ;; insert information of title and author
  ("h u z f tab" (insert (title-author-info)))

  ;; math environment
  ("d e f tab" (make 'definition))
  ("l e m tab" (make 'lemma))
  ("p r o p tab" (make 'proposition))
  ("t h m tab" (make 'theorem))
  ("p f tab" (make 'proof))
  ("n o t e tab" (make 'note))
  ("r k tab" (make 'remark))
  ("e x m tab" (make 'example))

  ("c m t tab" (my/comment))

  ;; insert a session
  ("g p tab" (my/session-small "gnuplot"))
  ("s c m tab" (my/session-small "scheme"))
  ("j l tab" (my/session-small "julia"))
  ("p y tab" (my/session-small "python"))
  ("g r a p h tab" (my/session-small "graph"))
  ("m m a tab" (my/session-small "mma"))
  ("m m a f o l d tab" (my/fold-small "mma" ""))
  ("g f o l d tab" (my/fold-small "graph" "%tikz -width 300"))
  ("m a x i m a tab"(my/session-small "maxima"))
  ("t k c d tab" (my/tikz #t))
  ("t k tab" (my/tikz #f))
  ("i n p u t tab" (my/input))

  ;; insert some code
  ("' ' ' c p p return"       (make 'cpp-code))
  ("' ' ' p y t h o n return" (make 'python-code))
  ("' ' ' s c m return"       (make 'scm-code)))

;; export to pdf
(tm-define (my/export-to-pdf)
  (with name (propose-name-buffer)
        (if (string-ends? name ".tm")
            (with pdf-name (string-append (string-drop-right name 3) ".pdf")
                  (wrapped-print-to-file pdf-name)))))

;; use small font for code
(tm-define (my/session-small type)
  (insert-go-to '(small "") '(0 0))
  (make-session type "default"))

(tm-define (my/fold-small type line)
  (insert-go-to `(center (small (script-input ,type "default" ,line ""))) `(0 0 2 ,(string-length line)))
  (insert-raw-return))

;; insert a tikz executable fold with prescribed text
(tm-define (my/tikz cd?)
  (:secure #t)
  (my/fold-small "tikz" "%tikz -width 0.318par")
;;  (insert-go-to '(center "") '(0 0))
;;  (insert-go-to '(script-input "tikz" "default" "" "") '(2 0))
;;  (insert "%tikz -width 0.318par")
  (when cd?
    (insert "\\usetikzlibrary{cd}")
    (insert-return)))

(tm-define (my/comment)
  (let ((s "[huzf: ]"))
      (insert-go-to `(with "color" "blue" ,s) `(2 ,(- (string-length s) 1)))))

(tm-define (my/input)
  (my/fold-small "graph" "%tikz -width 400")

  (insert "\\documentclass[10pt]{standalone}")
  (insert-raw-return)
  (insert "\\input{/home/huzf/tex-src/}")
  )

;; add a comment
;; (use-modules (various comment-edit))
;; (tm-define (my/comment)
;;   (:secure #t)
;;   (let* ((id (create-unique-id))
;;          (mirror-id (create-unique-id))
;;          (by "huzf")
;;          (date (number->string (current-time)))
;;          (lab (if (inside-comment?) 'nested-comment 'unfolded-comment))
;;          (pos (list 6 0))
;;          (type "comment"))
;;     (insert-go-to `(,lab ,id ,mirror-id ,type ,by ,date "" "") pos)
;;     ;;(notify-comments-editor)
;;     )
;;   )

;; insert the information of title and author
(tm-define (title-author-info)
  (:secure #t)
  '(document
     (doc-data
      (doc-title "(title here)")
      (doc-author
       (author-data
        (author-name "Huzf")
        (author-note
         (concat
          "Anhui University, Hefei, Anhui, China, 230601, "
          (hlink "hammer401@foxmail.com" "mailto:hammer401@foxmail.com")))))
      (doc-date (concat "(Dated: " (date "%B %e, %Y, %A") ")")))))


;; How to insert texts?
;;
;; Consecutive texts are yeilded by
;;   `(concat "hahaha" (hlink "clickme" "www.duckduckgo.com"))
;; like: (tm-define (h-text)
;;         `(concat "hahaha" (hlink "clickme" "127.0.0.1")))
;; Vectical consecutive texts are given by substituting `concat' by `document'
;;
;; Texts generated by <extern|horizontal-text> are uneditable,
;; while texts inserted by `insert' is editable.
;; If the scheme function contains some params, then params are still
;; editable under `extern', though inconvenient.
;; E.g., (tm-define (hello t) `(concat "Hello, " ,t "."))

(tm-define (in-theorem? t)
  (cond ((tree-is-buffer? t) #f)
        ((tree-is? t 'theorem) #t)
        (else (in-theorem? (tree-up t)))))

(tm-define (count n)
  (:secure #t)
  (with color (if (in-theorem? n) "red" "black")
        (with hop `(with "color" ,color ,n)
              (with k (string->number (tree->string n))
                    ($inline "Counting "
                             ($for (i (.. 1 k))
                                   (number->string i) ", ")
                             hop ".")))))

;; (load "init-joris-magic.scm")


