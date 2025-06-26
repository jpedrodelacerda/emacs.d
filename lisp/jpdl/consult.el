;;; consult.el --- Summary  -*- lexical-binding: t; -*-
;;; Commentary:

;;; Code:

(use-package consult
  :straight t
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :general
  ('keymaps 'global-map
            [remap project-find-regexp] 'consult-ripgrep)
  ("C-x C-n" 'consult-project-buffer
   "C-x C-b" 'consult-buffer
   "M-y" 'consult-yank-pop
   "C-/" 'jpdl/consult-toggle-preview
   "C-x C-l" 'consult-flymake)
  (jpdl/spc-leader
    "s h" 'consult-outline
    "s n" 'consult-project-buffer
    "s b" 'consult-buffer
    "s l" 'consult-line
    "l l" 'consult-line
    "4 s n" '(lambda () (interactive) (other-window-prefix) (consult-project-buffer))
    "4 s b" '(lambda () (interactive) (other-window-prefix) (consult-buffer))
    "r g" 'consult-ripgrep
    "l d" 'consult-flymake)
  :init
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)
  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :config
  (defvar consult--source-perspective
    (list :name     "Perspective"
          :narrow   ?s
          :category 'buffer
          :state    #'consult--buffer-state
          :default  t
          :items    #'persp-get-buffer-names))
  (defvar-local consult-toggle-preview-orig nil)
  (defun jpdl/consult-toggle-preview ()
    "Command to enable/disable preview."
    (interactive)
    (if consult-toggle-preview-orig
        (setq consult--preview-function consult-toggle-preview-orig
              consult-toggle-preview-orig nil)
      (setq consult-toggle-preview-orig consult--preview-function
            consult--preview-function #'ignore)))
  ;; (push consult--source-perspective consult-buffer-sources)
  (consult-customize consult-theme :preview-key '(:debounce 0.2 any)
                     consult-ripgrep consult-git-grep consult-grep
                     consult--source-buffer :default nil
                     consult-bookmark consult-recent-file consult-xref
                     consult--source-bookmark consult--source-file-register
                     consult--source-recent-file consult--source-project-recent-file)
  (add-to-list 'consult-buffer-sources persp-consult-source)
  (setq consult-narrow-key "<"
        consult-preview-key "M-.")
  (add-to-list 'vertico-multiform-commands '(consult-ripgrep buffer indexed))
  (add-to-list 'vertico-multiform-commands '(consult-grep buffer indexed))
  (add-to-list 'vertico-multiform-commands '(consult-git-grep buffer indexed)))

(use-package consult-project-extra
  :straight t
  :after (consult)
  :general
  ([remap project-find-file] 'consult-project-extra-find)
  ("C-x C-f" 'consult-project-extra-find
   "C-x 4 C-f" 'consult-project-extra-find-other-window)
  (jpdl/spc-leader
    "s f" 'consult-project-extra-find
    "4 s f" 'consult-project-extra-find-other-window))

(use-package consult-eglot
  :straight t
  :general
  (:keymaps 'eglot-mode-map
            "M-b" 'consult-eglot-symbols)
  (jpdl/spc-leader 'eglot-mode-map
    "l b" 'consult-eglot-symbols)
  :config
  (add-to-list 'vertico-multiform-commands '(consult-eglot-symbols buffer indexed)))

(use-package consult-gh
  :straight t
  :after consult
  :custom
  (consult-gh-default-clone-directory "~/projetos")
  (consult-gh-show-preview t)
  (consult-gh-preview-key "C-o")
  (consult-gh-repo-action #'consult-gh--repo-browse-files-action)
  (consult-gh-issue-action #'consult-gh--issue-view-action)
  (consult-gh-pr-action #'consult-gh--pr-view-action)
  (consult-gh-code-action #'consult-gh--code-view-action)
  (consult-gh-file-action #'consult-gh--files-view-action)
  (consult-gh-notifications-action #'consult-gh--notifications-action)
  (consult-gh-dashboard-action #'consult-gh--dashboard-action)
  (consult-gh-large-file-warning-threshold 2500000)
  (consult-gh-prioritize-local-folder 'suggest)
  :config
  (require 'consult-gh-transient)
  ;; Remember visited orgs and repos across sessions
  (add-to-list 'savehist-additional-variables 'consult-gh--known-orgs-list)
  (add-to-list 'savehist-additional-variables 'consult-gh--known-repos-list)
  ;; Enable default keybindings (e.g. for commenting on issues, prs, ...)
  (consult-gh-enable-default-keybindings))


;; Install `consult-gh-embark' for embark actions
(use-package consult-gh-embark
  :straight t
  :after consult-gh
  :config
  (consult-gh-embark-mode +1))

;; Install `consult-gh-forge' for forge actions
(use-package consult-gh-forge
  :straight t
  :after consult-gh
  :config
  (consult-gh-forge-mode +1)
  (setq consult-gh-forge-timeout-seconds 20))

(use-package consult-org-roam
  :straight t
  :after org-roam
  :hook (after-init . consult-org-roam-mode)
  :custom
  ;; Use `ripgrep' for searching with `consult-org-roam-search'
  (consult-org-roam-grep-func #'consult-ripgrep)
  ;; Configure a custom narrow key for `consult-buffer'
  (consult-org-roam-buffer-narrow-key ?r)
  ;; Display org-roam buffers right after non-org-roam buffers
  ;; in consult-buffer (and not down at the bottom)
  (consult-org-roam-buffer-after-buffers t)
  :general
  ("C-c n e" 'consult-org-roam-file-find
   "C-c n b" 'consult-org-roam-backlinks
   "C-c n B" 'consult-org-roam-backlinks-recursive
   "C-c n l" 'consult-org-roam-forward-links
   "C-c n r" 'consult-org-roam-search)
  (jpdl/spc-leader
    "n e" 'consult-org-roam-file-find
    "n b" 'consult-org-roam-backlinks
    "n B" 'consult-org-roam-backlinks-recursive
    "n l" 'consult-org-roam-forward-links
    "n r" 'consult-org-roam-search))

(provide 'jpdl/consult)
;;; consult.el ends here
