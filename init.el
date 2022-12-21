(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(lsp-treemacs command-log-mode lsp-pyright clang-format ivy magit conda transpose-frame ripgrep projectile exec-path-from-shell company lsp-ui rust-mode lsp-mode web-mode-edit-element add-node-modules-path prettier emmet-mode prettier-js web-mode typescript-mode cmake-mode which-key use-package doom-themes)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(setq auto-save-file-name-transforms
      `((".*" "~/.emacs-saves/" t)))
(setq backup-directory-alist `(("." . "~/.emacs-saves")))

(eval-when-compile
  (require 'use-package))

(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

(use-package command-log-mode
  :commands command-log-mode
  :hook prog-mode)

(setq-default indent-tabs-mode nil)
(setq visible-bell t)
(column-number-mode)
(global-display-line-numbers-mode t)

(use-package doom-themes
  :init (load-theme 'doom-palenight t))  ;; also like doom-gruvbox

(use-package which-key
  :config
  (which-key-mode))

(use-package js-mode
  :mode "\\.[jt]sx?\\'"
  :config
  (setq js-indent-level 2))

(eval-after-load 'js-mode
  (progn
    (add-hook 'js-mode-hook #'add-node-modules-path)
    (add-hook 'js-mode-hook #'emmet-mode)
    (add-hook 'js-mode-hook #'prettier-js-mode)))

(use-package rust-mode
  :init (add-to-list 'exec-path "~/.cargo/bin")
  :hook prettify-symbols
  :config
  (setq indent-tabs-mode nil)
  (setq rust-format-on-save t))

(use-package ivy
  :diminish
  :config
  (ivy-mode 1))

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
              ("<tab>" . company-complete-selection))
  (:map lsp-mode-map
        ("<tab>" . company-indent-or-complete-common)))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/clones")
    (setq projectile-project-search-path '("~/clones")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package lsp
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")  
  (setq lsp-clients-clangd-args '("--header-insertion-decorators=0" "--limit-references=0" "--log=verbose"))
  :hook (c++-mode c-mode))

(add-to-list 'auto-mode-alist '("\\.py*" . python-mode))
(add-to-list 'auto-mode-alist '("\\.pxi*" . python-mode))
(require 'conda)
;; if you want auto-activation (see below for details), include:
;;(conda-env-autoactivate-mode t)
;; if you want to automatically activate a conda environment on the opening of a file:

(defun my-conda-hook()
  (when (and (and(stringp buffer-file-name)
                 (string-match "\\.py*\\'" buffer-file-name))
             (not (bound-and-true-p conda-env-current-name)))
    (conda-env-activate-for-buffer)))

(add-hook 'find-file-hook 'my-conda-hook)

(use-package lsp-pyright
  :hook (python-mode . (lambda ()
                         (lsp-deferred))))

(defun my-cpp-setup ()
  (c-set-offset 'innamespace [0]))
(add-hook 'c++-mode-hook 'my-cpp-setup)

;;(use-package clang-format
;;  :hook c++-mode)
