;;; prog.el --- Summary  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(require 'jpdl/utils)

(use-package smart-semicolon
  :straight t
  :hook
  (rust-ts-mode . jpdl/setup-smart-semicolon)
  (nix-ts-mode . jpdl/setup-smart-semicolon-nix)
  :config
  (defun jpdl/setup-smart-semicolon ()
    "Configure `smart-semicolon'"
    (interactive)
    (setq-local smart-semicolon-block-chars '(?, ?\; ?\( ?{))
    (smart-semicolon-mode t))
  (defun jpdl/setup-smart-semicolon-nix ()
    "Configure `smart-semicolon' for `nix-ts-mode'"
    (interactive)
    (setq-local smart-semicolon-block-chars '(?, ?\; ?\( ?{))
    (smart-semicolon-mode t)))

(use-package typst-ts-mode
  :straight (:host sourcehut :repo "meow_king/typst-ts-mode")
  :mode ("\\.typ\\'" . typst-ts-mode)
  :general
  (jpdl/spc-leader :keymaps '(typst-ts-mode-map)
    "t c" 'typst-ts-compile)
  :custom
  (typst-ts-mode-watch-options "--open")
  :config
  (add-to-list 'lsp-language-id-configuration '(typst-ts-mode . "tinymist"))
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection "tinymist")
    :major-modes '(typst-ts-mode)
    :server-id 'tinymist)))

(use-package websocket
  :straight t)

(use-package typst-preview
  :straight (:host github :repo "havarddj/typst-preview.el")
  :general
  (jpdl/spc-leader :keymaps '(typst-ts-mode)
    "t p" 'typst-preview-mode
    "t j" 'typst-preview-send-position
    "t r" 'typst-preview-restart)
  :config
  (setq typst-preview-executable "tinymist preview")
  (setq typst-preview-browser "default"))

(use-package mermaid-mode
  :straight t
  :mode "\\.mmd\\'")

;; Dockerfiles
(use-package dockerfile-mode
  :straight t
  :mode "Dockerfile\\'")

;; Elixir
(use-package elixir-ts-mode
  :straight t
  :hook (elixir-ts-mode . eglot-ensure)
  :mode ("\\.exs\\'"
         "\\.ex\\'"))

(use-package alchemist
  :straight t
  :after (elixir-mode which-key)
  :config
  (which-key-add-major-mode-key-based-replacements 'elixir-mode
    "C-c a"     "alchemist"
    "C-c a m"   "mix"
    "C-c a m t" "mix-test"
    "C-c a X"   "hex"
    "C-c a c"   "compile"
    "C-c a e"   "execute"
    "C-c a p"   "project"
    "C-c a n"   "phoenix"
    "C-c a h"   "help"
    "C-c a i"   "iex"
    "C-c a v"   "eval"
    "C-c a o"   "macroexpand"
    "C-c a f"   "info"))

;; gleam
(use-package gleam-ts-mode
  :straight t
  :mode (rx ".gleam" eos))

;; Lua
(use-package lua-mode
  :straight t
  :hook (lua-mode . eglot-ensure)
  :mode "\\.lua\\'")

;; Nix
(use-package nix-mode
  :straight t
  :hook (nix-mode . eglot-ensure)
  :mode "\\.nix\\'"
  :config
  (add-to-list 'eglot-server-programs
               '((nix-mode nix-ts-mode) . ("nil" :initializationOptions
                                           (:formatting (:command ["alejandra"]))))))

(use-package nix-ts-mode
  :straight t
  :hook (nix-ts-mode . eglot-ensure)
  :mode "\\.nix\\'")

(use-package nix-update
  :straight t
  :general ("C-c C-n u" 'nix-update-fetch))

;; Jinja2
(use-package jinja2-mode
  :straight t
  :mode "\\.j2\\'")

;; JavaScript
(use-package js-ts-mode
  :straight (:type built-in)
  :defer t
  :hook (js-ts-mode . eglot-ensure)
  :mode ("\\.js\\'"
         "\\.mjs\\'"))

;; TypeScript
(use-package typescript-ts-mode
  :straight (:type built-in)
  :hook
  (typescript-ts-mode . eglot-ensure)
  :mode (("\\.ts\\'" . typescript-mode)))

(use-package jtsx
  :straight t
  :mode (("\\.tsx\\'" . jtsx-tsx-mode))
  :hook
  (jtsx-tsx-mode . eglot-ensure)
  :commands jtsx-install-treesit-language
  :custom
  (js-ident-level 2)
  (jtsx-enable-jsx-electric-closing-element t)
  (jtsx-enable-electric-open-newline-between-jsx-element-tags t)
  (jtsx-enable-jsx-element-tags-auto-sync t)
  (jtsx-enable-all-syntax-highlighting-features t))


;; Astro
(use-package astro-ts-mode
  :straight t
  :after (treesit)
  :hook (astro-ts-mode . eglot-ensure)
  :mode "\\.astro\\'")

;; =markdown=
(use-package markdown-mode
  :straight t
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.mdx\\'" . markdown-mode))
  :custom
  (markdown-command '("pandoc" "--from=markdown" "--to=html5")))

;; =markdown=
(use-package markdown-ts-mode
  :straight (:type built-in))

(use-package markdown-toc
  :straight (:host github :repo "jpedrodelacerda/markdown-toc")
  :general
  (:keymaps '(markdown-ts-mode-map markdown-mode-map)
            "C-c m t" 'markdown-toc-generate-or-refresh-toc)
  (jpdl/spc-leader :keymaps '(markdown-ts-mode-map markdown-mode-map)
    "mt" 'markdown-toc-generate-or-refresh-toc))

(use-package grip-mode
  :straight t
  :custom
  (gripq-command 'go-grip)
  (grip-preview-use-webkit t)
  :general
  (:keymaps '(markdown-ts-mode-map markdown-mode-map)
            "C-c m g" 'grip-mode)
  (jpdl/spc-leader :keymaps '(markdown-ts-mode-map markdown-mode-map)
    "mg" 'grip-mode))

;; Go
;; (use-package go-ts-mode
;;   :straight (:type built-in)
(use-package go-mode
  :straight t
  :mode "\\.go\\'"
  :hook (go-ts-mode . eglot-ensure)
  :config
  ;;  Setting =\\GOPATH=
  (setenv "GOPATH" (concat home "/go"))
  (jpdl/append-to-path (concat (getenv "GOPATH") "/bin")))

;; (use-package python-ts-mode
;;   :straight (:type built-in)
(use-package python-mode
  :straight t
  :hook (python-ts-mode . eglot-ensure)
  :custom
  (python-indent-guess-indent-offset nil)
  :config
  (jpdl/append-to-path "~/.local/bin")
  (add-to-list 'eglot-server-programs
               '((python python-ts-mode) . ("ruff" "server"))))

(use-package pyvenv
  :straight t
  :init
  (setopt pyvenv-mode-line-indicator '(pyvenv-virtual-env-name ("[" pyvenv-virtual-env-name "] ")))
  :config
  (pyvenv-mode 1))

(use-package python-black
  :straight t
  :after python-mode
  :hook (python-mode . python-black-on-save-mode))

(use-package code-cells
  :straight t
  :hook
  (python-mode . code-cells-mode-maybe)
  (after-revert . code-cells-convert-ipynb)
  :general
  ;; (:keymaps 'code-cells-mode-map
  ;;           ("M-p" . code-cells-backward-cell)
  ;;           ("M-n" . code-cells-forward-cell)
  ;;           ("C-c C-c" . code-cells-eval))
  (jpdl/spc-leader :keymaps 'code-cells-mode-map
    "c n" 'code-cells-forward-cell
    "c p" 'code-cells-backward-cell
    "c e" 'code-cells-eval
    "c E" 'code-cells-eval-whole-buffer
    "c d" 'code-cells-duplicate)
  :custom
  (code-cells-convert-ipynb-style '(("pandoc" "--to" "ipynb" "--from" "org")
                                    ("pandoc" "--to" "org" "--from" "ipynb")
                                    ;; ("pandoc" "--to" "org" "--from" "ipynb" "--ipynb-output=none")
                                    (lambda () #'org-mode)))
  :config
  (with-eval-after-load 'code-cells
    (let ((map code-cells-mode-map))
      (define-key map [remap evil-search-next] (code-cells-speed-key 'code-cells-forward-cell)) ;; n
      (define-key map [remap evil-paste-after] (code-cells-speed-key 'code-cells-backward-cell)) ;; p
      (define-key map [remap evil-backward-word-begin] (code-cells-speed-key 'code-cells-eval-above)) ;; b
      (define-key map [remap evil-forward-word-end] (code-cells-speed-key 'code-cells-eval)) ;; e
      (define-key map [remap evil-jump-forward] (code-cells-speed-key 'outline-cycle)))) ;; TAB
  (defun jpdl/code-cells-revert
      (interactive)
    (code-cells-convert-ipynb))
  (defun jpdl/code-cells-insert ()
    (interactive)
    (when (not (bolp))
      (newline 2))
    (insert (substring code-cells-boundary-regexp 1))
    (newline 2))

  ;;   (defun jpdl/code-cells-write-ipynb (&optional file)
  ;;     "Convert buffer to ipynb format and write to FILE.
  ;; Interactively, asks for the file name.  When called from Lisp,
  ;; FILE defaults to the current buffer file name."
  ;;     (interactive "F")
  ;;     (let* ((file (or file buffer-file-name))
  ;;            (ox-ipynb-export-to-ipynb-file))
  ;;       ;; (exit (code-cells--call-process temp (ox-ipynb-export-org-file-to-ipynb-file))))
  ;;       ;; (exit (code-cells--call-process temp (car code-cells-convert-ipynb-style))))
  ;;       ;; (with-current-buffer temp
  ;;       ;;   (write-region nil nil file)
  ;;       ;;   (kill-buffer))
  ;;       (when (eq file buffer-file-name)
  ;;         (set-buffer-modified-p nil)
  ;;         (set-visited-file-modtime))
  ;;       'job-done))

  ;;   (defun code-cells-convert-ipynb ()
  ;;     "Convert buffer from ipynb format to a regular script."
  ;;     (let* ((mode (funcall (caddr code-cells-convert-ipynb-style)))
  ;;            (exit (progn
  ;;                    (goto-char (point-min))
  ;;                    (code-cells--call-process t (cadr code-cells-convert-ipynb-style)))))
  ;;       (unless (zerop exit)
  ;;         (delete-region (point-min) (point))
  ;;         (error "Error converting notebook (exit code %s)" exit))
  ;;       (delete-region (point) (point-max))
  ;;       (goto-char (point-min))
  ;;       (set-buffer-modified-p nil)
  ;;       (add-hook 'write-file-functions #'jpdl/code-cells-write-ipynb 80 t)
  ;;       (when (fboundp mode)
  ;;         (funcall mode)
  ;;         (run-hooks (cadddr code-cells-convert-ipynb-style)))))
  ;; (add-hook 'write-file-functions #'jpdl/code-cells-write-ipynb 80 t)
  )

;; (use-package ein
;;   :straight t
;;   :commands (ein:run ein:login)
;;   ;; :mode ("\\.ipynb\\'" . ein:ipynb-mode)
;;   :general
;;   (jpdl/spc-leader :keymaps 'ein:notebook-mode-map
;;     "C-c C-c" 'ein:worksheet-execute-cell
;;     "C-c C-a" 'ein:worksheet-execute-all-cells
;;     "C-c C-n" 'ein:worksheet-goto-next-input
;;     "C-c C-p" 'ein:worksheet-goto-prev-input
;;     "C-c C-k" 'ein:worksheet-kill-cell
;;     "C-c C-y" 'ein:worksheet-yank-cell
;;     "C-c C-o" 'ein:worksheet-clear-output)
;;   (jpdl/spc-leader :keymaps 'ein:notebook-mode-map
;;     "c c" 'ein:worksheet-execute-cell
;;     "c a" 'ein:worksheet-execute-all-cells
;;     "c n" 'ein:worksheet-goto-next-input
;;     "c p" 'ein:worksheet-goto-prev-input
;;     "c k" 'ein:worksheet-kill-cell
;;     "c y" 'ein:worksheet-yank-cell
;;     "c o" 'ein:worksheet-clear-output))
;; ;; :custom
;; ;; (ein:jupyter-default-server-command 'jupyter)
;; ;; (ein:jupyter-server-use-subcommand 'notebook))

(defun jpdl/new-notebook (notebook-name &optional kernel)
  "Creates an empty notebook in the current directory with an associated kernel."
  (interactive "sEnter the notebook name: ")
  (when (file-name-extension notebook-name)
    (setq notebook-name (file-name-sans-extension notebook-name)))
  (unless kernel
    (setq kernel
          (jupyter-kernelspec-name
           (jupyter-completing-read-kernelspec))))
  (unless (executable-find "jupytext")
    (error "Can't find \"jupytext\""))
  (let ((notebook-py (concat notebook-name ".py")))
    (shell-command (concat "touch " notebook-py))
    (shell-command
     (concat "jupytext --set-kernel " kernel " " notebook-py))
    (shell-command (concat "jupytext --to notebook " notebook-py))
    (shell-command (concat "rm " notebook-py))
    (message
     (concat
      "Notebook successfully created at " notebook-name ".ipynb"))))

(use-package jupyter
  :straight t
  :general
  (jpdl/spc-leader :keymaps 'jupyter-org-interaction-mode-map
    "c ?" 'jupyter-org-inspect-src-block
    "c r" 'jpdl/jupyter-org-restart-kernel)
  :custom
  (jupyter-long-timeout 100)
  :config
  (setq jupyter-use-zmq t)
  (inheritenv-add-advice 'jupyter-command)
  (advice-add 'jupyter-command :around #'envrc-propagate-environment)
  (setq org-babel-default-header-args:jupyter-python
        '((:results . "both")
	      ;; This seems to lead to buffer specific sessions!
	      (:session . (lambda () (buffer-file-name)))
	      (:kernel . "python3")
	      (:pandoc . "t")
	      (:exports . "both")
	      (:cache .   "no")
	      (:noweb . "no")
	      (:hlines . "no")
	      ;; (:tangle . "no")
	      (:eval . "never-export")))

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (julia . t)
     (python . t)
     (jupyter . t)))
  (require 'org-src)
  (require 'ob-async)
  (require 'ob-jupyter)
  (require 'jupyter)
  (require 'jupyter-org-client)

  (org-babel-jupyter-aliases-from-kernelspecs)

  (defun jpdl/jupyter-org-restart-kernel ()
    "Restart the kernel of the source block where point is."
    (interactive)
    (jupyter-org-with-src-block-client
     (jupyter-repl-restart-kernel)))

  (defun jupyter-repl-sync-execution-state-1 (timeout)
    (jupyter-run-with-client jupyter-current-client
      (jupyter-mlet* ((_msg (jupyter-reply
                             (jupyter-execute-request
                              :code ""
                              :silent t
                              :handlers nil)
                             timeout)))
        (jupyter-return nil))))

  (defun jupyter-repl-sync-execution-state ()
    "Synchronize the `jupyter-current-client's kernel state.
    Also update the cell count of the current REPL input prompt using
    the updated state."
    (let* ((deadline (+ (float-time) jupyter-long-timeout))
           (timeout 0.05))
      (while
          (condition-case nil
              (jupyter-repl-sync-execution-state-1 timeout)
            (jupyter-timeout-before-idle
             (let ((remaining (- deadline (float-time))))
               (when (< remaining 0)
                 (signal 'jupyter-timeout-before-idle '("connect timeout")))
               (setf timeout
                     (min remaining
                          (max (expt timeout 1.5) 1.0))))))))
    (let ((client jupyter-current-client))
      (unless (equal (jupyter-execution-state client) "busy")
        ;; Set the cell count and update the prompt
        (jupyter-with-repl-buffer client
          (save-excursion
            (goto-char (point-max))
            (jupyter-repl-update-cell-count
             (oref client execution-count))))))
    nil))

(use-package toml-ts-mode
  :straight (:type built-in)
  :mode "\\.toml\\'")

;;  =rust-mode=
(use-package rust-ts-mode
  :straight t
  :mode "\\.rs\\'"
  :hook (rust-ts-mode . eglot-ensure)
  :custom
  (rust-mode-treesitter-derive (and (fboundp 'treesit-available-p)
                                    (treesit-available-p)))
  (rust-ts-flymake-command '("cargo" "clippy")))

(use-package cargo
  :straight t
  :hook (rust-ts-mode . cargo-minor-mode))

;; sh
(add-hook 'sh-mode-hook
          (lambda ()
            (setq sh-basic-offset 2
                  sh-indentation 2)))

;; Terraform
(use-package terraform-mode
  :straight t
  :mode ("\\.tf\\'"
         "\\.tfvars\\'"
         "\\.tfstate\\'")
  :hook (terraform-mode . eglot-ensure)
  :config '(terraform-indent-level 4))

(use-package nushell-mode
  :straight t
  :mode "\\.nu\\'"
  :hook (nushell-mode . eglot-ensure))

;; =yaml-mode=
(use-package yaml-ts-mode
  :straight (:type built-in)
  :hook (yaml-ts-mode . eglot-ensure)
  :mode ("\\.yml\\'"
         "\\.yaml\\'"))

(use-package yaml-pro
  :straight t
  :after (yaml-ts-mode)
  :hook (yaml-ts-mode . yaml-pro-ts-mode)
  :general
  (:keymaps 'yaml-pro-ts-mode-map
            "C-c C-f" 'yaml-pro-format-ts)
  (jpdl/spc-leader :keymaps 'yaml-pro-ts-mode-map
    "ff" 'yaml-pro-format-ts))

;; sql-indent.el
(use-package sql-indent
  :straight t)

;; =web-mode=
(use-package web-mode
  :straight t
  :mode ("\\.eex\\'"
         "\\.gohtml\\'"
         "\\.html\\'"
         "\\.s?css\\'"
         "\\.php\\'")
  :hook (web-mode-hook . (lambda () (rainbow-mode) (setq web-mode-markup indent-offset 2))))

(use-package rainbow-mode
  :straight t
  :hook (prog-mode . rainbow-mode))

(use-package elm-mode
  :straight t
  :mode ("\\.elm")
  :hook (elm-mode . eglot-ensure))

(use-package yuck-mode
  :straight t
  :mode "\\.yuck\\'")

(use-package dart-mode
  :straight t
  :mode ("\\.dart\\'")
  :hook
  (dart-mode . eglot-ensure)
  :config
  (add-hook 'eglot-managed-mode-hook (lambda ()
                                       (eglot-inlay-hints-mode -1)
                                       (run-at-time 1 nil (lambda () (eglot-inlay-hints-mode 1))))))

(use-package flutter
  :straight t
  :after dart-mode
  :hook
  (dart-mode . flutter-test-mode)
  :general
  (:keymaps 'dart-mode-map
            "C-M-x" 'flutter-run-or-hot-reload)
  (jpdl/spc-leader :keymaps '(dart-mode-map)
    "f r" 'flutter-run-or-hot-reload
    "f t" 'flutter-test-all
    "f p" 'flutter-test-at-point))

(use-package just-ts-mode
  :straight t
  :mode ("\\justfile\\'"))

(use-package emacs-lisp-ts-mode
  :straight (:host github :repo "gabrielfrigo4/emacs-lisp-ts-mode"))

(provide 'jpdl/prog)
;;; prog.el ends here
