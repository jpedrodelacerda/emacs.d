;;; Summary - lsp.el
;;; Comentary: lsp and lsp-ui config
;;;
;;; Code:

;; LSP completes me
(use-package lsp-mode
  :commands (lsp)
  :hook ((dart-mode . lsp)
         (elm-mode . lsp)
         (elixir-mode . lsp)
         (go-mode . lsp)
         (c-mode . lsp)
         (c++-mode . lsp)
         (web-mode . lsp)
         (js-mode . lsp)
         (rust-mode . lsp)
         (python-mode . lsp)
	 (before-save-hook . lsp-format-buffer))
  :bind (:map lsp-mode-map
	      (("C-c C-f" . lsp-format-buffer)))
  :config
  (setq
    lsp-signature-auto-activate t
    lsp-signature-doc-lines 1)
  (setq lsp-diagnostics-provider :auto)
  (setq lsp-enable-indentation t)
  (setq lsp-enable-snippet t)
  (setq lsp-enable-on-type-formatting nil)
  (setq lsp-enable-xref t)
  (add-hook 'js-mode 'lsp)
  (setq lsp-enable-file-watchers t)
  (setq lsp-eldoc-render-all nil))

(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :diminish
  :bind (:map lsp-ui-mode-map
              ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
              ([remap xref-find-references] . lsp-ui-peek-find-references)
              ("C-c u" . lsp-ui-imenu))
  :custom-face
  (lsp-ui-doc-background ((t (:background nil))))
  (lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic)))))
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-position 'top)
  (lsp-ui-doc-border (face-foreground 'default))
  (lsp-ui-sideline-ignore-duplicate t)
  (lsp-ui-sideline-show-code-actions t)
  :config
  (setq lsp-ui-doc-use-webkit t))

(provide 'jpdl/lsp)
;;; lsp.el ends here
