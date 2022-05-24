(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(lsp-treemacs projectile-ripgrep ripgrep typescript-mode magit helpful ivy which-key doom-themes clang-format treemacs emmet-mode lsp-ui lsp-mode company web-mode js2-mode prettier-js google-c-style)))

(setq auto-save-file-name-transforms
      `((".*" "~/.emacs-saves/" t)))
(setq backup-directory-alist `(("." . "~/.emacs-saves")))

(require 'use-package)

;; Google C style guide
(add-hook 'c++-mode-hook 'google-set-c-style)
(add-hook 'c++-mode-hook 'google-make-newline-indent)

;;(use-package web-mode
;; :mode "\\.js\\'"
;;  :config
;;  (setq web-mode-enable-auto-expanding t))
;;(use-package prettier-js-mode
;;  :init
;;  (setq js-indent-level 2)
;;  :hook (web-mode js-mode))
;;(use-package company-mode
;;  :hook (js-mode))
;;;;(require 'lsp)
;;(use-package lsp-mode
;;  :commands (lsp lsp-deferred)
;;  :hook (js-mode)
;;  :init
;;  (setq lsp-keymap-prefix "C-c l"))
;;(use-package emmet-mode
;;  :hook (js-mode))
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

(setq visible-bell t)
(column-number-mode)

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

(use-package ivy
  :config
  (ivy-mode 1))

(use-package projectile
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/clones")
    (setq projectile-project-search-path '("~/clones")))
  (setq projectile-switch-project-action #'projectile-dired))
(use-package projectile-ripgrep)

(use-package magit
  :commands magit-status)
	       
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :after lsp)
