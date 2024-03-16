;;; system.el --- Summary

;;; Commentary:

;;; Code:

(require 'jpdl/font)

(setq gc-cons-threshold 100000000)
(setq warning-minimum-level :emergency)

;; No start-up mesage
(setq inhibit-startup-message t)

;; Remove trailing whitespace before saving file
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(global-auto-revert-mode t)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package use-package-chords
  :straight t
  :config (key-chord-mode 1))

(use-package auto-package-update
  :straight t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package subword
  :straight t
  :config
  (global-subword-mode))

;; Undo function
(use-package undo-fu
  :straight t
  :config
  (global-unset-key (kbd "C-z"))
  :bind
  ("C-z" . undo-fu-only-undo)
  ("C-S-z" . undo-fu-only-redo)
  ("C-/" . undo-fu-only-redo))

(use-package undo-fu-session
  :straight t
  :config
  (setq undo-fu-session-incompatible-files '("/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'"))
  (undo-fu-session-global-mode))

(use-package vundo
  :straight t)

(use-package which-key
  :straight t
  :config (which-key-mode))

;; No tabs
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; Disable lock files
(setq create-lockfiles nil)

;; no scroll bars
(set-window-scroll-bars (minibuffer-window) nil nil)

(use-package yasnippet
  :straight t
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets/text-mode"))
  (yas-global-mode 1))

(use-package yasnippet-snippets)

(use-package minions
  :straight t
  :config
  (minions-mode 1))

(use-package centered-cursor-mode
  :straight t
  :after (evil)
  :diminish centered-cursor-mode
  :commands (centered-cursor-mode
             global-centered-cursor-mode)
  ;; :hook (after-init-hook . centered-cursor-mode)
  :bind (:map evil-normal-state-map
              ("zz" . centered-cursor-mode)))
  ;; :hook (prog-mode . centered-cursor-mode))

(use-package rg
  :straight t)
(use-package ripgrep
  :straight t)

(use-package editorconfig
  :straight t
  :config
  (editorconfig-mode 1))

(use-package direnv
  :straight t
  :config
  (direnv-mode))

(use-package harpoon
  :straight t
  :after (evil)
  :bind (
         ("C-c a" . harpoon-quick-menu-hydra)
         ("C-c h <return>" . harpoon-add-file)
         ("C-c h c" . harpoon-clear)
         ("C-c h h" . harpoon-toggle-quick-menu)
         ("C-c h f" . harpoon-toggle-file)
         ("C-c h 1" . harpoon-go-to-1)
         ("C-c h 2" . harpoon-go-to-2)
         ("C-c h 3" . harpoon-go-to-3)
         ("C-c h 4" . harpoon-go-to-4)
         ("C-c h 5" . harpoon-go-to-5)
         ("C-c h 6" . harpoon-go-to-6)
         ("C-c h 7" . harpoon-go-to-7)
         ("C-c h 8" . harpoon-go-to-8)
         ("C-c h 9" . harpoon-go-to-9)
         :map evil-normal-state-map
         ("SPC a" . harpoon-quick-menu-hydra)
         ("SPC h <return>" . harpoon-toggle-quick-menu)
         ("SPC h h" . harpoon-add-file)
         ("SPC h c" . harpoon-clear)
         ("SPC h f" . harpoon-toggle-file)
         ("SPC h 1" . harpoon-go-to-1)
         ("SPC h 2" . harpoon-go-to-2)
         ("SPC h 3" . harpoon-go-to-3)
         ("SPC h 4" . harpoon-go-to-4)
         ("SPC h 5" . harpoon-go-to-5)
         ("SPC h 6" . harpoon-go-to-6)
         ("SPC h 7" . harpoon-go-to-7)
         ("SPC h 8" . harpoon-go-to-8)
         ("SPC h 9" . harpoon-go-to-9)))

(provide 'jpdl/system)
;;; system.el ends here
