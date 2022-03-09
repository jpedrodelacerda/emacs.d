;;; lsp.el --- Summary

;;; Commentary:
;; lsp and lsp-ui config

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
         (typescript-mode . lsp)
         (rust-mode . lsp)
         (python-mode . lsp)
	 (before-save-hook . lsp-format-buffer))
  :bind-keymap (("C-a" . lsp-command-map))
  :bind ((:map lsp-mode-map
	           (("C-c C-f" . lsp-format-buffer)
	            ("C-c r" . lsp-rename)
	            ("C-c a" . lsp-execute-code-action))))
  :config
  (setq
    lsp-signature-auto-activate t
    lsp-signature-doc-lines 1)
  (setq lsp-diagnostics-provider :auto)
  (setq lsp-enable-indentation t)
  (setq lsp-enable-snippet t)
  (setq lsp-enable-on-type-formatting nil)
  (setq lsp-enable-xref t)
  (setq lsp-enable-file-watchers t)
  (setq lsp-rust-analyzer-server-display-inlay-hints t)
  (setq lsp-elm-elm-language-server-path "elm-language-server"))

(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :diminish
  :bind (:map lsp-ui-mode-map (:map evil-normal-state-map
                                    ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
                                    ([remap xref-find-references] . lsp-ui-peek-find-references)
	                                ("g d" . lsp-ui-peek-find-definitions)
	                                ("g r" . lsp-ui-peek-find-references)
	                                ("g i" . lsp-ui-peek-find-implementation)
	                                ("g b" . xref-pop-marker-stack)
                                    ("C-c u" . lsp-ui-imenu)))
  :chords (:map evil-normal-state-map
		        ("gd" . lsp-ui-peek-find-definitions)
		        ("gr" . lsp-ui-peek-find-references)
		        ("gi" . lsp-ui-peek-find-implementation)
		        ("gb" . xref-pop-marker-stack))
  :custom-face
  (lsp-ui-doc-background ((t (:background nil))))
  (lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic)))))
  :config
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-doc-header t)
  (setq lsp-ui-doc-include-signature t)
  (setq lsp-ui-doc-position 'top)
  (setq lsp-ui-doc-border (face-foreground 'default))
  (setq lsp-ui-doc-show-with-mouse t)
  (setq lsp-ui-doc-show-with-cursor t)
  (setq lsp-ui-sideline-ignore-duplicate t)
  (setq lsp-ui-sideline-show-code-actions t)
  (setq lsp-ui-doc-use-webkit t))

(use-package helm-lsp
  :bind ("C-x g" . helm-lsp-workspace-symbol))

(use-package lsp-treemacs
  :config
  (lsp-treemacs-sync-mode 1)
  :bind
  (:map lsp-mode-map
        ("M-q" . lsp-treemacs-symbols)))

(provide 'jpdl/lsp)
;;; lsp.el ends here
