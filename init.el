(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("3e200d49451ec4b8baa068c989e7fba2a97646091fd555eca0ee5a1386d56077" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "e1f4f0158cd5a01a9d96f1f7cdcca8d6724d7d33267623cc433fe1c196848554" "c5878086e65614424a84ad5c758b07e9edcf4c513e08a1c5b1533f313d1b17f1" "2bd8ad41d7c70771c57f8e446be6760e05bc1d1f111d2d984607f644e904b4ca" default))
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(solarized-theme eglot dart-mode ox-epub flycheck-cython cython-mode cfml-mode yasnippet pyvenv ox-ipynb s quelpa jupyter hcl-mode markdown-mode ess lsp-treemacs command-log-mode lsp-pyright clang-format ivy magit conda transpose-frame ripgrep projectile exec-path-from-shell company lsp-ui rust-mode lsp-mode web-mode-edit-element add-node-modules-path prettier emmet-mode prettier-js web-mode typescript-mode cmake-mode which-key use-package doom-themes)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(setf auto-save-file-name-transforms
      `((".*" "~/.emacs-saves/" t)))
(setf backup-directory-alist `(("." . "~/.emacs-saves")))

(eval-when-compile
  (require 'use-package))

(setf inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

(setq-default indent-tabs-mode nil)
(setf visible-bell t)
(column-number-mode)
(global-display-line-numbers-mode t)

(load-theme 'solarized-wombat-dark t)

(use-package which-key
  :config
  (which-key-mode))

(use-package rust-mode
  :init (add-to-list 'exec-path "~/.cargo/bin")
  :hook prettify-symbols
  :config
  (setf indent-tabs-mode nil)
  (setf rust-format-on-save t))

(use-package ivy
  :diminish
  :config
  (ivy-mode 1))

(use-package company
  :bind (:map company-active-map
              ("<tab>" . company-complete-selection)))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/clones")
    (setf projectile-project-search-path '("~/clones")))
  (setf projectile-switch-project-action #'projectile-dired))

(add-to-list 'auto-mode-alist '("\\.py*" . python-mode))
;;(add-to-list 'auto-mode-alist '("\\.pxi*" . python-mode))
(add-to-list 'auto-mode-alist '("\\meson.build" . python-mode))
(add-to-list 'auto-mode-alist '("\\.tf\\'" . hcl-mode))

(defun my-cpp-setup ()
  (c-set-offset 'innamespace [0]))
(add-hook 'c++-mode-hook 'my-cpp-setup)

(add-hook 'prog-mode-hook 'eglot-ensure)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python . t)
   (jupyter . t)))

(use-package ox-ipynb)
(use-package ox-epub)

(add-hook 'write-file-hooks 'delete-trailing-whitespace nil t)

(setf org-confirm-babel-evaluate nil)

;; https://emacs.stackexchange.com/questions/2387/browser-not-opening-when-exporting-html-from-org-mode
(setf org-file-apps
      (quote
       ((auto-mode . emacs)
        ("\\.mm\\'" . default)
        ("\\.x?html?\\'" . "/usr/bin/firefox %s")
        ("\\.pdf\\'" . default))))

;; https://orgmode.org/worg/org-faq.html#closing-outline-sections
(require 'org-inlinetask)

(add-hook 'org-mode-hook
          (lambda ()
            (toggle-truncate-lines nil)))

;; https://github.com/emacs-jupyter/jupyter/issues/471
(setq jupyter-use-zmq nil)
