(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
 '(package-selected-packages
   '(rust-mode lsp-mode web-mode-edit-element add-node-modules-path prettier emmet-mode prettier-js web-mode typescript-mode cmake-mode which-key use-package doom-themes)))
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs-saves/" t)))
(setq backup-directory-alist `(("." . "~/.emacs-saves")))

(require 'use-package)

;; Google C style guide
(add-hook 'c++-mode-hook 'google-set-c-style)
(add-hook 'c++-mode-hook 'google-make-newline-indent)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; all below is heavily inspired by
;; https://github.com/daviwil/emacs-from-scratch/blob/master/init.el
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

(setq-default indent-tabs-mode nil)
(setq visible-bell t)
(column-number-mode)
(global-display-line-numbers-mode t)

(set-face-attribute 'default nil :font "Fira Code Retina")
;; https://github.com/mickeynp/ligature.el
;; https://github.com/tonsky/FiraCode/wiki/Emacs-instructions
(use-package ligature
  :load-path "/home/willayd/clones/ligature.el"
  :config
  (ligature-set-ligatures 't '("www"))
  (ligature-set-ligatures 'prog-mode '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\" "{-" "::"
                                     ":::" ":=" "!!" "!=" "!==" "-}" "----" "-->" "->" "->>"
                                     "-<" "-<<" "-~" "#{" "#[" "##" "###" "####" "#(" "#?" "#_"
                                     "#_(" ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*" "/**"
                                     "/=" "/==" "/>" "//" "///" "&&" "||" "||=" "|=" "|>" "^=" "$>"
                                     "++" "+++" "+>" "=:=" "==" "===" "==>" "=>" "=>>" "<="
                                     "=<<" "=/=" ">-" ">=" ">=>" ">>" ">>-" ">>=" ">>>" "<*"
                                     "<*>" "<|" "<|>" "<$" "<$>" "<!--" "<-" "<--" "<->" "<+"
                                     "<+>" "<=" "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<"
                                     "<~" "<~~" "</" "</>" "~@" "~-" "~>" "~~" "~~>" "%%"))
  
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

(use-package doom-themes
  :init (load-theme 'doom-palenight t))  ;; also like doom-gruvbox

(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle-delay .4))

;; Typescript development
(use-package js-mode
  :mode "\\.[jt]sx?\\'")

(eval-after-load 'js-mode
  (progn
    (add-hook 'js-mode-hook #'add-node-modules-path)
    (add-hook 'js-mode-hook #'web-mode-hook
    (add-hook 'js-mode-hook #'emmet-mode)
    (setq js-indent-level 2)))
                 
(use-package rust-mode
  :init (add-to-list 'exec-path "~/.cargo/bin")
  :hook prettify-symbols
  :config
  (setq indent-tabs-mode nil)
  (setq rust-format-on-save t))
