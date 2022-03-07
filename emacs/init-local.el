;;; package --- Summary
;;; Commentary:
;;; Code:

(defun my/general-init ()
  "General intiation."

  ;; Emacs appearence
  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  (tool-bar-mode -1)

  ;; set path, no need to do it manually in general
  ;;(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
  ;;(setq exec-path (append exec-path '("/usr/local/bin")))

  (setq
   make-backup-files nil
   inhibit-startup-screen t
   visible-bell t

   ;; if this variable is not nil, org-mode cannot call
   ;; xdg-open correctly
   process-connection-type nil
   )
  )

(my/general-init)

(require-package 'org-bullets)
(require-package 'pdf-tools)
(require-package 'org-static-blog)

(require-package 'leuven-theme)
(require-package 'cyberpunk-theme)
(require-package 'tron-legacy-theme)
(require-package 'color-theme-modern)

(require-package 'poet-theme)

(require-package 'rust-mode)
(require-package 'julia-mode)
(require-package 'lsp-mode)
(require-package 'markdown-mode)
;;(require-package 'julia-repl)
(require-package 'vterm)
(require-package 'julia-snail)


;;(require-package 'ess)
(require-package 'ein)
;;(require-package 'ob-ipython)
;;(require-package 'ob-ess-julia)
;;(defalias 'org-babel-execute:julia 'org-babel-execute:ess-julia)

(require-package 'treemacs)
;;(require-package 'dap-mode)
;;(require-package 'yasnippet)
;;(require-package 'helm-xref)

(pdf-loader-install)

;; cycle color themes
(setq my/color-themes
      '(leuven-dark
	leuven
	cyberpunk
        ;;tron-legacy
        kingsajz
        pok-wog
        aliceblue
        poet)
      themes-to-cycle nil)

(defun my/theme-cycle ()
  "Switch to next theme."
  (interactive)
  (if (equal themes-to-cycle nil)
      (setq themes-to-cycle my/color-themes))
  (let ((theme-current (car themes-to-cycle)))
    (load-theme theme-current t)
    (message "%s" theme-current)
    (setq themes-to-cycle (cdr themes-to-cycle))))

(my/theme-cycle)

(global-set-key [f4] 'my/theme-cycle)
(global-set-key [f5] 'treemacs)
(global-set-key (kbd "C-c C-t") 'treemacs-display-current-project-exclusively)


;;(set-frame-font "FiraCode Nerd Font Mono 11" nil t)
(set-face-font 'default "FiraCode Nerd Font Mono 14") ;; for x11
(set-face-attribute 'fixed-pitch nil :family "FiraCode Nerd Font Mono")
(set-face-attribute 'variable-pitch nil :family "Noto Serif")
;;(set-face-font 'default "FiraCode Nerd Font Mono 13") ;; for wayland
;;(set-face-font 'default "Source Code Pro 10")
;;(set-face-font 'default "Hack 10")
(set-fontset-font t 'symbol "Noto Color Emoji")


;; set window size
(defun set-frame-size-according-to-resolution ()
  "Dynamically set window size."
  (if (window-system)
      (progn
	(if (> (x-display-pixel-width) 1280)
	    (add-to-list 'default-frame-alist (cons 'width 120))
	  (add-to-list 'default-frame-alist (cons 'width 60)))
	(add-to-list 'default-frame-alist
		     (cons 'height (/ (- (x-display-pixel-height) 180)
				      (frame-char-height)))))))
;; besides, `(if (window-system) (set-frame-size (selected-frame) 124 40))`
;; is also nice and concise
;;(set-frame-size-according-to-resolution)
;;(add-to-list 'default-frame-alist (cons 'width 130))
;;(add-to-list 'default-frame-alist (cons 'height 50))

;; ============================== Julia
;;(add-hook 'julia-mode-hook 'julia-repl-mode)
(add-hook 'julia-mode-hook 'julia-snail-mode)

;; (defun my/ijulia-console ()
;;   "Runs IJulia in a `term' buffer."
;;   (interactive)
;;   (require 'term)
;;   (let* ((rawjlversion (shell-command-to-string "julia --version"))
;;          (jversion (replace-regexp-in-string " version \\([^.]*[.][^.]*\\).*$" "-\\1" rawjlversion))
;;          (cmd "jupyter")
;;          (args (concat " console --kernel=" jversion))
;;          (switches (split-string-and-unquote args))
;;          (termbuf (apply 'make-term "IJulia Console" cmd nil switches)))
;;     (set-buffer termbuf)
;;     (term-mode)
;;     (term-char-mode)
;;     (switch-to-buffer termbuf)))

;; (defun my/julia-repl ()
;;   "Runs Julia in a screen session in a `term' buffer."
;;   (interactive)
;;   (require 'term)
;;   (let* ((args (split-string-and-unquote "julia"))
;;          (termbuf (apply 'make-term "Julia REPL" "screen" nil args)))
;;     (set-buffer termbuf)
;;     (term-mode)
;;     (term-char-mode)
;;     (switch-to-buffer termbuf)))

;; ============================== Julia end

;; ============================== ein
;;(setq ein:output-area-inlined-images t)
;; ============================== ein end

;; ============================== org-mode
(add-hook 'text-mode-hook
          (lambda ()
            ;;            (variable-pitch-mode 1)
            ))

(with-eval-after-load 'org
  (setq truncate-lines nil)
  (setq truncate-lines nil)
  (setq org-format-latex-options
        (plist-put org-format-latex-options :scale 2.0))
  (setq org-html-validation-link t)
  (setq org-startup-numerated t)
  (setq org-num-skip-commented t)
  (setq org-num-skip-unnumbered t)
  (setq org-num-skip-footnotes t)
  (setq org-src-fontify-natively t)
  (setq org-startup-folded 'content)
  ;;(setq org-export-with-toc nil)

  (setq org-bullets-face-name 'org-bullet-face)
  (setq org-bullets-bullet-list '("✙" "♱" "♰" "☥" "✞" "✟" "✝" "†" "✠" "✚" "✜" "✛" "✢" "✣" "✤" "✥"))
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (shell . t)
     (ruby . t)
     (gnuplot . t)
     (emacs-lisp . t)
     ;;(ess-julia . t)
     (C . t)
     (latex . t)
     ;;(ein . t)
     ;;(ipython . t)
     ))
  )



(defun my/org-inline-css-hook (exporter)
  "Redefine the html `EXPORTER'.
Insert custom inline css to automatically set the background of code to whatever theme I'm using."
  (when (eq exporter 'html)
    (let* ((my-pre-bg (face-background 'default))
	   (my-pre-fg (face-foreground 'default)))
      (setq org-html-head-extra
	    (concat
	     org-html-head-extra
	     (format "<style type=\"text/css\"> pre.src { background-color: %s; color: %s; } </style>" my-pre-bg my-pre-fg))))))
;; (add-hook 'org-export-before-processing-hook 'my/org-inline-css-hook)

(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))

(add-to-list 'org-latex-classes
             '("ethz"
               "\\documentclass[a4paper,11pt,titlepage]{memoir}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{fixltx2e}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}
\\usepackage{rotating}
\\usepackage[normalem]{ulem}
\\usepackage{amsmath}
\\usepackage{textcomp}
\\usepackage{marvosym}
\\usepackage{wasysym}
\\usepackage{amssymb}
\\usepackage{hyperref}
\\usepackage{mathpazo}
\\usepackage{color}
\\usepackage{enumerate}
\\definecolor{bg}{rgb}{0.95,0.95,0.95}
\\tolerance=1000
      [NO-DEFAULT-PACKAGES]
      [PACKAGES]
      [EXTRA]
\\linespread{1.1}
\\hypersetup{pdfborder=0 0 0}"
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
             '("article"
               "\\documentclass[11pt,a4paper]{article}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{fixltx2e}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}
\\usepackage{rotating}
\\usepackage[normalem]{ulem}
\\usepackage{amsmath}
\\usepackage{textcomp}
\\usepackage{marvosym}
\\usepackage{wasysym}
\\usepackage{amssymb}
\\usepackage{hyperref}
\\usepackage{mathpazo}
\\usepackage{color}
\\usepackage{enumerate}
\\definecolor{bg}{rgb}{0.95,0.95,0.95}
\\tolerance=1000
      [NO-DEFAULT-PACKAGES]
      [PACKAGES]
      [EXTRA]
\\linespread{1.1}
\\hypersetup{pdfborder=0 0 0}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")))

(add-to-list 'org-latex-classes
             '("ebook"
               "\\documentclass[11pt, oneside]{memoir}
\\setstocksize{9in}{6in}
\\settrimmedsize{\\stockheight}{\\stockwidth}{*}
\\setlrmarginsandblock{2cm}{2cm}{*} % Left and right margin
\\setulmarginsandblock{2cm}{2cm}{*} % Upper and lower margin
\\checkandfixthelayout
% Much more laTeX code omitted
"
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")))

;; ============================== org-mode end

(add-hook 'find-file-hook 'auto-insert)
(setq auto-insert-query nil)
;; (setq auto-insert-directory "~/.mytemplates/")
;; from which auto-inserted files are taken
(eval-after-load 'autoinsert
  '(define-auto-insert '(org-mode . "Org skeleton")
     '("Description: "
       "#+TITLE: " \n
       "#+AUTHOR: Hammer Hu" \n
       "#+DATE: " (format-time-string "%A,%e %B, %Y, %H:%M") \n
       "#+SETUPFILE: " \n
       \n)))


(setq-default
 ;; c-basic-offset 4
 python-indent-offset 4
 )


(add-hook 'scheme-mode-hook
          (lambda ()
            (put 'tm-define 'scheme-indent-function 1)
            (put 'tm-menu 'scheme-indent-function 1)))

;;(lsp-treemacs-sync-mode 1)

;;(require 'helm-xref)
;;(define-key global-map [remap find-file] #'helm-find-files)
;;(define-key global-map [remap execute-extended-command] #'helm-M-x)
;;(define-key global-map [remap switch-to-buffer] #'helm-mini)

;;(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)
(add-hook 'rust-mode-hook 'lsp)

(setq ;;gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimul-prefix-length 1
      lsp-idle-delay 0.1) ;; clangd is fase

;;(with-eval-after-load 'lsp-mode
;;  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
;;  (require 'dap-cpptools)
;;  (yas-global-mode))


(provide 'init-local)
;;; init-local ends here
