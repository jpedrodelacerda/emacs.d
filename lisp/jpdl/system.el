;;; system.el --- Summary

;;; Commentary:

;;; Code:

(require 'jpdl/font)

(setq gc-cons-threshold 100000000)

;; Remove trailing whitespace before saving file
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(global-auto-revert-mode t)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package use-package-chords
  :config (key-chord-mode 1))

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package subword
  :config
  (global-subword-mode))

;; Undo function
(use-package undo-tree
  :config (global-undo-tree-mode)
  :bind (
         ("C-/" . undo-redo)))

(use-package which-key
  :config (which-key-mode))

;; No tabs
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; Disable lock files
(setq create-lockfiles nil)

;; no scroll bars
(set-window-scroll-bars (minibuffer-window) nil nil)

;; No start-up mesage
(setq inhibit-startup-message t)

(use-package yasnippet
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets/text-mode"))
  (yas-global-mode 1))

(use-package minions
  :config
  (minions-mode 1))

(use-package rg)
(use-package ripgrep)

(use-package editorconfig
  :config
  (editorconfig-mode 1))

(provide 'jpdl/system)
;;; system.el ends here
