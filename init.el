(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("3bf80e2e3f2c3dd0295be05d2e44815e7d810c2b1cb3fb8fe1a7bc50634f5f0e" "b579486e2ebd9d36460ea4b976fa37c845f8158506d85626b95b4c9a37baafee" "54047744cbb0de08c5591f3fe4a819cc6d550e312b490c588bce11d041d61cc1" "712166475816156b9faeae7b42953296fa0967b061598470ae7ab0d26bcf2c41" "1975855abd3275efe27c49cac8386c3912733ec106cbadf969e371c625941002" "891cf99ff093c965fd7a5dd9a0122783ae678444afec77fc1bd6350d8dc45a3e" "d393d418cac62d024af05f25ed2a0cd92115417684e9fd61d2f0a7dcb1dcdc2b" "babfd0d32561d4afb6ba0f0ccfe9fd15d1c209d16b3ac796c27f434fec60dbfe" "5331f36284c063183f974fa586b6af84b1a7200dbde5802f295131f129bd1e3f" "0f5867c6d5c9f8c98de70cd5be78ff6799b87166e78e3ecd23617108dabb0cab" "bf08d37ebbad67f0748f216ed2af6ec2d4387fc225be245c43ab64844dea458b" "3994b1c5c1f412c025bb71b2df5973a421c257afee5278684639c205d79d93ee" "b52b2f39598253df2d54edeaa8516bd7b5346e5c0fdf04076b14d9b2ad03a657" "985d398b7391c6d653e94c7bc0255d492a13c2fe80d2b8c5d0f40e828ef7b561" "3074fda75f35f990d112fb75681729a74b6c7f15d3e5dfcf80313abb4cd39ed8" "137c792e21ec0c02f71c23d3342cbad5a39c5468f032798ac3e2004e0d254930" "bb613853010a8b4c4d18ed8adcfc233990c88fa4ef266ccd9a54a635848e6d55" "1e2d250d8d45cfb34f2ddf7475e5d1784835f2f52c78ddd4d91e6e667a2d55a8" "2bd8ad41d7c70771c57f8e446be6760e05bc1d1f111d2d984607f644e904b4ca" default))
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(ivy magit transpose-frame ripgrep projectile exec-path-from-shell company rust-mode web-mode-edit-element web-mode typescript-mode cmake-mode which-key use-package)))
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

(setq-default indent-tabs-mode nil)
(setq visible-bell t)
(column-number-mode)
(global-display-line-numbers-mode t)

(load-theme 'popOS t)

(use-package which-key
  :config
  (which-key-mode))

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
    (setq projectile-project-search-path '("~/clones")))
  (setq projectile-switch-project-action #'projectile-dired))

(add-to-list 'auto-mode-alist '("\\.py*" . python-mode))
(add-to-list 'auto-mode-alist '("\\.pxi*" . python-mode))

(defun my-cpp-setup ()
  (c-set-offset 'innamespace [0]))
(add-hook 'c++-mode-hook 'my-cpp-setup)
