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

   url-proxy-services
   '(("http" . "127.0.0.1:7891")
     ("https" . "127.0.0.1:7891"))
   )
  )

(my/general-init)


(require-package 'leuven-theme)
(require-package 'cyberpunk-theme)
(require-package 'julia-mode)
(require-package 'lsp-mode)
;;(require-package 'dap-mode)
;;(require-package 'yasnippet)
;;(require-package 'helm-xref)


;; cycle color themes
(setq my/color-themes
      '(leuven-dark
	leuven
	cyberpunk)
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
(set-face-font 'default "FiraCode Nerd Font Mono 11") ;; for x11
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
(add-to-list 'default-frame-alist (cons 'width 100))
(add-to-list 'default-frame-alist (cons 'height 50))

;; ============================== Julia
(defun ijulia-console ()
  "Runs IJulia in a `term' buffer."
  (interactive)
  (require 'term)
  (let* ((rawjlversion (shell-command-to-string "julia --version"))
         (jversion (replace-regexp-in-string " version \\([^.]*[.][^.]*\\).*$" "-\\1" rawjlversion))
         (cmd "jupyter")
         (args (concat " console --kernel=" jversion))
         (switches (split-string-and-unquote args))
         (termbuf (apply 'make-term "IJulia Console" cmd nil switches)))
    (set-buffer termbuf)
    (term-mode)
    (term-char-mode)
    (switch-to-buffer termbuf)))

(defun julia-repl ()
  "Runs Julia in a screen session in a `term' buffer."
  (interactive)
  (require 'term)
  (let* ((args (split-string-and-unquote "julia"))
         (termbuf (apply 'make-term "Julia REPL" "screen" nil args)))
    (set-buffer termbuf)
    (term-mode)
    (term-char-mode)
    (switch-to-buffer termbuf)))

;; ============================== Julia end

;; ============================== org-mode
(add-hook 'org-mode-hook
	  (lambda ()
	    (setq

	     truncate-lines nil
	     org-format-latex-options (plist-put
				       org-format-latex-options :scale 2.0)
	     org-html-validation-link t
	     org-startup-numerated t
	     org-num-skip-commented t
	     org-num-skip-unnumbered t
	     org-num-skip-footnotes t
	     org-src-fontify-natively t
             org-startup-folded 'content)))


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
       "#+DATE: " (format-time-string "%A, %e %B %Y %H:%M") \n
       "#+SETUPFILE: " \n
       \n)))


;; highlight parentheses
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
;;(add-hook 'rust-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
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
