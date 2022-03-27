;;; package --- Summary
;;; Commentary:

;;; Code:
(setq
 url-proxy-services '(("http" . "127.0.0.1:7891")
                      ("https" . "127.0.0.1:7891"))
 package-archives
 '(
   ;;("gnu" . "http://mirrors.ustc.edu.cn/elpa/gnu/")
   ;;("melpa" . "http://mirrors.ustc.edu.cn/elpa/melpa/")
   ;;("melpa-stable" . "http://mirrors.ustc.edu.cn/elpa/stable-melpa/")
   ;;("org" . "http://mirrors.ustc.edu.cn/elpa/org/")

   ("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
   ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
   ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
   ("melpa-stable" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/stable-melpa/")
   ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
   ;;("melpa-stable" . "http://elpa.zilongshanren.com/stable-melpa/")
   )
 )

(provide 'init-preload-local)
;;; init-preload-local.el ends here
