;;; lsp.el --- Summary  -*- lexical-binding: t; -*-

;;; Commentary:
;; lsp and lsp-ui config

;;; Code:
(use-package eglot
  :straight (:type built-in)
  :after cape
  :general
  (:keymaps 'eglot-mode-map
            "C-c f" 'eglot-format-buffer
            "C-c r" 'eglot-rename
            "C-c a" 'eglot-code-actions
            "C-c q" 'eglot-code-action-quickfix
            "C-c o" 'eglot-code-action-organize-imports)
  (jpdl/spc-leader :keymaps 'eglot-mode-map
    "l f" 'eglot-format-buffer
    "l r" 'eglot-rename
    "l a" 'eglot-code-actions
    "l q" 'eglot-code-action-quickfix
    "l o" 'eglot-code-action-organize-imports)
  :config
  (setq eglot-autoshutdown t
        eglot-confirm-server-initiated-edits nil)
  ;; Corfu: set Orderless + Eglot
  ;; (add-to-list 'completion-category-overrides '(eglot (styles orderless))))
  ;; (setq completion-category-overrides '((eglot (styles orderless))
  ;;                                       (eglot-capf (styles orderless))))
  ;; (setq completion-category-defaults nil)
  (add-to-list
   'eglot-server-programs
   '((js-mode js-ts-mode tsx-ts-mode typescript-ts-mode typescript-mode)
     "typescript-language-server" "--stdio"
     ;; I totally came up with these myself
     :initializationOptions
     (:preferences
      (
       :includeInlayEnumMemberValueHints t
       :includeInlayFunctionLikeReturnTypeHints t
       :includeInlayFunctionParameterTypeHints t
       :includeInlayParameterNameHints "all" ; "none" | "literals" | "all"
       :includeInlayParameterNameHintsWhenArgumentMatchesName t
       :includeInlayPRopertyDeclarationTypeHints t
       :includeInlayVariableTypeHints t
       :includeInlayVariableTypeHintsWhenTypeMatchesName t))))
  (advice-add 'eglot-completion-at-point :around #'cape-wrap-buster))

(use-package eglot-booster
  :straight (:host github :repo "jdtsmith/eglot-booster")
  :after eglot
  :config
  (eglot-booster-mode))

(use-package xref
  :straight (:type built-in)
  :general
  (:keymaps 'evil-normal-state-map
            "gp" 'xref-go-back
            "gn" 'xref-go-forward
            "gd" 'xref-find-definitions
            "gr" 'xref-find-references)
  (jpdl/spc-leader
    "g p" 'xref-go-back
    "g n" 'xref-go-forward
    "g d" 'xref-find-definitions
    "g r" 'xref-find-references))

(use-package eldoc
  :straight (:type built-in)
  :custom
  (eldoc-echo-area-use-multiline-p nil))

(use-package eldoc-box
  :straight t
  :general
  (:keymaps 'eglot-mode-map
            "M-1" 'jpdl/eldoc-box-toggle)
  (jpdl/spc-leader
    "d t" 'jpdl/eldoc-box-toggle)
  :preface
  (defun jpdl/eldoc-box-visible-p ()
    "Return whether the `eldoc-box' popup is visible."
    (and eldoc-box--frame (frame-visible-p eldoc-box--frame)))

  (defun jpdl/eldoc-box-toggle ()
    "Toggle the `eldoc-box-help-at-point' popup."
    (interactive)
    (require 'eldoc-box)
    (if (jpdl/eldoc-box-visible-p)
        (eldoc-box-quit-frame)
      (eldoc-box-help-at-point)))
  :custom
  (eldoc-box-max-pixel-width 600)
  (eldoc-box-max-pixel-height 800)
  :config
  (advice-add 'keyboard-quit :before #'eldoc-box-quit-frame))

(provide 'jpdl/lsp)
;;; lsp.el ends here
