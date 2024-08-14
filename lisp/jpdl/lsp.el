;;; lsp.el --- Summary

;;; Commentary:
;; lsp and lsp-ui config

;;; Code:
(defun lsp-booster--advice-json-parse (old-fn &rest args)
  "Try to parse bytecode instead of json."
  (or
   (when (equal (following-char) ?#)
     (let ((bytecode (read (current-buffer))))
       (when (byte-code-function-p bytecode)
         (funcall bytecode))))
   (apply old-fn args)))
(advice-add (if (progn (require 'json)
                       (fboundp 'json-parse-buffer))
                'json-parse-buffer
              'json-read)
            :around
            #'lsp-booster--advice-json-parse)

(defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
  "Prepend emacs-lsp-booster command to lsp CMD."
  (let ((orig-result (funcall old-fn cmd test?)))
    (if (and (not test?)                             ;; for check lsp-server-present?
             (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
             lsp-use-plists
             (not (functionp 'json-rpc-connection))  ;; native json-rpc
             (executable-find "emacs-lsp-booster"))
        (progn
          (message "Using emacs-lsp-booster for %s!" orig-result)
          (cons "emacs-lsp-booster" orig-result))
      orig-result)))
(advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command)

;; LSP completes me
(use-package lsp-mode
  :straight t
  :commands (lsp)
  :after (posframe)
  :hook ((before-save-hook . lsp-format-buffer)
         (lsp . lsp-inlay-hints-mode))
  :general
  (:keymaps 'lsp-mode-map
	        "C-c C-f" 'lsp-format-buffer
	        "C-c r" 'lsp-rename
	        "C-c a" 'lsp-execute-code-action
            "C-c l" 'lsp-avy-lens)
  (jpdl/spc-leader
    "l f" 'lsp-format-buffer
    "l r" 'lsp-rename
    "l a" 'lsp-execute-code-action
    "l l" 'lsp-avy-lens)
  :config
  (setq lsp-signature-auto-activate t
        lsp-signature-doc-lines 1
        lsp-completion-show-kind t
        lsp-signature-function 'lsp-signature-posframe
        lsp-diagnostics-provider :auto
        lsp-enable-indentation t
        lsp-enable-snippet t
        lsp-enable-on-type-formatting nil
        lsp-enable-xref t
        lsp-enable-file-watchers t
        lsp-inlay-hint-enable t
        lsp-javascript-display-parameter-type-hints t
        lsp-javascript-display-property-declaration-type-hints t
        lsp-javascript-display-return-type-hints t
        lsp-javascript-display-variable-type-hints t
        lsp-nix-nil-formatter ["nixpkgs-fmt"]
        lsp-rust-analyzer-diagnostics-disabled ["unresolved-proc-macro"]
        lsp-elm-elm-language-server-path "elm-language-server")
  (with-eval-after-load 'lsp-mode
    (lsp-register-client
     (make-lsp-client :new-connection (lsp-stdio-connection '("astro-ls" "--stdio"))
                      :major-modes '(astro-ts-mode)
                      :priority 0
                      :server-id 'astro-ls)))
  (with-eval-after-load 'lsp-mode
    (lsp-register-client
     (make-lsp-client :new-connection (lsp-stdio-connection "nil")
                      :major-modes '(nix-ts-mode nix-mode)
                      :priority 0
                      :server-id 'nil)))
  (with-eval-after-load 'lsp-mode
    (lsp-register-client
     (make-lsp-client :new-connection (lsp-stdio-connection "nu --lsp")
                      :major-modes '(nushell-mode)
                      :priority 0
                      :server-id 'nu))))

(use-package posframe
  :straight t)

(use-package lsp-ui
  :straight t
  :after lsp-mode
  :commands lsp-ui-mode
  :diminish
  :general
  (:keymaps 'lsp-ui-mode-map
            [remap xref-find-definitions] 'lsp-ui-peek-find-definitions
            "<f12>" 'lsp-ui-peek-find-definitions
            "<f9>" 'lsp-ui-imenu
            [remap xref-find-references] 'lsp-ui-peek-find-references
            "C-1" 'lsp-ui-doc-toggle
            "`" 'lsp-ui-doc-toggle
            "C-c u" 'lsp-ui-imenu)
  (jpdl/spc-leader
    "g d" 'lsp-ui-peek-find-definitions
    "g r" 'lsp-ui-peek-find-references
    "g i" 'lsp-ui-peek-find-implementation
    "g b" 'xref-go-back)
  (:keymaps 'evil-normal-state-map
		        "gd" 'lsp-ui-peek-find-definitions
		        "gr" 'lsp-ui-peek-find-references
		        "gi" 'lsp-ui-peek-find-implementation
		        "gb" 'xref-go-back)
  :custom-face
  (lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic)))))
  (lsp-ui-sideline-code-action ((t (:inherit warning))))
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-header t
        lsp-ui-doc-include-signature t
        lsp-ui-doc-position 'at-point
        lsp-ui-doc-border (face-foreground 'default)
        lsp-ui-doc-show-with-mouse t
        lsp-ui-doc-show-with-cursor nil
        lsp-ui-sideline-ignore-duplicate t
        lsp-ui-sideline-show-code-actions t
        lsp-ui-doc-use-webkit nil))

;; (use-package lsp-ivy
;;   :straight t
;;   :after (lsp ivy)
;;   :general
;;   (:keymaps 'lsp-mode-map
;;             "M-b" 'lsp-ivy-workspace-symbol
;;             "M-n" 'lsp-ivy-global-workspace-symbol))

(use-package consult-lsp
  :straight t
  :after (lsp consult)
  :general
  (:keymaps 'lsp-mode-map
            "M-b" 'consult-lsp-file-symbols
            "M-n" 'consult-lsp-symbols)
  (jpdl/spc-leader 'lsp-mode-map
    "l d" 'consult-lsp-diagnostics
    "l b" 'consult-lsp-file-symbols
    "l n" 'consult-lsp-symbols))

(use-package lsp-treemacs
  :straight t
  :after (treemacs)
  :config
  (lsp-treemacs-sync-mode 1)
  :general
  (:keymaps 'lsp-mode-map
        "M-g" 'lsp-treemacs-symbols))

(use-package lsp-origami
  :straight t
  :after (lsp origami)
  :hook (lsp-after-open . lsp-origami-try-enable))

(provide 'jpdl/lsp)
;;; lsp.el ends here
