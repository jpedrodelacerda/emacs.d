;;;; system.el --- Summary  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(require 'jpdl/font)

(require 'iso-transl)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024))
(setq warning-minimum-level :emergency)

;; No start-up mesage
(setq inhibit-startup-message t)

(use-package exec-path-from-shell
  :init (exec-path-from-shell-initialize))

;; Remove trailing whitespace before saving file
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(global-auto-revert-mode t)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(setq use-dialog-box nil)
(setopt use-short-answers t)
(define-key minibuffer-local-completion-map (kbd "SPC") 'self-insert-command)

(use-package keychain-environment
  :straight t
  :config (keychain-refresh-environment))

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
  :straight t)

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
  :custom
  (yas-snippet-dirs '("~/.emacs.d/snippets"))
  :config
  (yas-global-mode 1))

(use-package auto-yasnippet
  :straight t
  :after yasnippet)

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
  :general (:states '(normal)
                    "zz" 'global-centered-cursor-mode))

(use-package rg
  :straight t)

(use-package ripgrep
  :straight t)

(use-package editorconfig
  :straight t
  :config
  (editorconfig-mode 1))

(use-package envrc
  :straight t
  :hook (after-init . envrc-global-mode))

(use-package inheritenv
  :straight t
  :config
  (advice-add 'org-babel-execute-src-block :around #'inheritenv-apply)
  (advice-add 'process-file :around #'inheritenv-apply))

(use-package drag-stuff
  :straight t
  :general
  ("M-S-<up>" 'drag-stuff-up
   "M-S-<down>" 'drag-stuff-down)
  :config
  (drag-stuff-global-mode 1))

;; (use-package origami
;;   :straight (origami :type git :host github :repo "elp-revive/origami.el")
;;   :after (evil)
;;   :general
;;   ("M-<tab>" 'origami-toggle-node
;;    "C-M-<tab>" 'origami-recursively-toggle-node
;;    "C-M-<escape>" 'origami-reset)
;;   (jpdl/spc-leader
;;     "o t" 'origami-toggle-node
;;     "o a" 'origami-toggle-all-nodes
;;     "o r" 'origami-recursively-toggle-node
;;     "o z" 'origami-reset)
;;   (:states '(normal)
;;            "zq" 'origami-toggle-node
;;            "za" 'origami-toggle-all-nodes
;;            "zw" 'origami-recursively-toggle-node
;;            "zx" 'origami-reset)
;;   :config
;;   (global-origami-mode))

(use-package harpoon
  :straight t
  :after (evil)
  :general
  ("C-c h m" 'harpoon-quick-menu-hydra
   "C-c h <return>" 'harpoon-toggle-quick-menu
   "C-c h h" 'harpoon-add-file
   "C-c h c" 'harpoon-clear
   "C-c h p" 'harpoon-toggle-file
   "C-c TAB" 'harpoon-go-to-next
   "C-c <backtab>" 'harpoon-go-to-prev
   "C-c h q" 'harpoon-go-to-1
   "C-c h w" 'harpoon-go-to-2
   "C-c h e" 'harpoon-go-to-3
   "C-c h r" 'harpoon-go-to-4
   "C-c h t" 'harpoon-go-to-5
   "C-c h y" 'harpoon-go-to-6
   "C-c h u" 'harpoon-go-to-7
   "C-c h i" 'harpoon-go-to-8
   "C-c h o" 'harpoon-go-to-9
   "C-c h Q" 'harpoon-delete-1
   "C-c h W" 'harpoon-delete-2
   "C-c h E" 'harpoon-delete-3
   "C-c h R" 'harpoon-delete-4
   "C-c h T" 'harpoon-delete-5
   "C-c h Y" 'harpoon-delete-6
   "C-c h U" 'harpoon-delete-7
   "C-c h I" 'harpoon-delete-8
   "C-c h O" 'harpoon-delete-9)
  (jpdl/spc-leader
    "h m"        'harpoon-quick-menu-hydra
    "h <return>" 'harpoon-toggle-quick-menu
    "h h" 'harpoon-add-file
    "h c" 'harpoon-clear
    "h p" 'harpoon-toggle-file
    "h TAB" 'harpoon-go-to-next
    "h <backtab>" 'harpoon-go-to-next
    "h q" 'harpoon-go-to-1
    "h w" 'harpoon-go-to-2
    "h e" 'harpoon-go-to-3
    "h r" 'harpoon-go-to-4
    "h t" 'harpoon-go-to-5
    "h y" 'harpoon-go-to-6
    "h u" 'harpoon-go-to-7
    "h i" 'harpoon-go-to-8
    "h o" 'harpoon-go-to-9
    "h Q" 'harpoon-delete-1
    "h W" 'harpoon-delete-2
    "h E" 'harpoon-delete-3
    "h R" 'harpoon-delete-4
    "h T" 'harpoon-delete-5
    "h Y" 'harpoon-delete-6
    "h U" 'harpoon-delete-7
    "h I" 'harpoon-delete-8
    "h O" 'harpoon-delete-9)
  (:states '(normal)
           "f <return>" 'harpoon-toggle-quick-menu
           "f m" 'harpoon-quick-menu-hydra
           "f p" 'harpoon-toggle-file
           "f f" 'harpoon-add-file
           "f c" 'harpoon-clear
           "f TAB" 'harpoon-go-to-next
           "f <backtab>" 'harpoon-go-to-prev
           "f q" 'harpoon-go-to-1
           "f w" 'harpoon-go-to-2
           "f e" 'harpoon-go-to-3
           "f r" 'harpoon-go-to-4
           "f t" 'harpoon-go-to-5
           "f y" 'harpoon-go-to-6
           "f u" 'harpoon-go-to-7
           "f i" 'harpoon-go-to-8
           "f o" 'harpoon-go-to-9
           "f Q" 'harpoon-delete-1
           "f W" 'harpoon-delete-2
           "f E" 'harpoon-delete-3
           "f R" 'harpoon-delete-4
           "f T" 'harpoon-delete-5
           "f Y" 'harpoon-delete-6
           "f U" 'harpoon-delete-7
           "f I" 'harpoon-delete-8
           "f O" 'harpoon-delete-9
           ))

(use-package sops
  :straight t
  :general
  ("C-c C-c" 'sops-save-file
   "C-c C-k" 'sops-cancel
   "C-c C-d" 'sops-edit-file)
  (:keymap '(yaml-ts-mode-map yaml-pro-ts-mode-map)
           "C-c C-c" 'sops-save-file
           "C-c C-k" 'sops-cancel
           "C-c C-d" 'sops-edit-file)
  :config
  (global-sops-mode 1))


(use-package easysession
  :straight t
  :hook
  (after-init . easysession-setup)
  (after-init . easysession-scratch-mode)
  (after-init . easysession-magit-mode)
  :general
  (jpdl/spc-leader
    "e s" 'easysession-save
    "e l" 'easysession-switch-to
    "e L" 'easysession-switch-to-and-restore-geometry
    "e r" 'easysession-rename
    "e R" 'easysession-reset
    "e u" 'easysession-unload
    "e d" 'easysession-delete)
  :config
  (setq easysession-save-interval (* 10 60)
        easysession-switch-to-save-session t
        easysession-mode-line-misc-info t
        easysession-switch-to-exclude-current nil))

(provide 'jpdl/system)
;;; system.el ends here
