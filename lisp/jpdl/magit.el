;;; magit.el --- Summary

;;; Commentary:

;;; Code:

;; Magic handler for git
(use-package magit
  :straight t
  :general
  (:keymaps 'global-map
            [remap project-vc-dir] 'magit-project-status)
  ("C-x g" 'magit-status)
  (jpdl/spc-leader
    "g g" 'magit-status)
  :hook
  ;; Start commit message in insert state.
  (with-editor-mode . evil-insert-state)
  :config
  (use-package with-editor)
  (setq magit-push-always-verify nil)
  (setq git-commit-summary-max-length 50))

(use-package forge
  :straight t
  :after magit)

(use-package git-gutter
  :straight t
  :config
  (setq git-gutter:update-interval 0.02)
  (global-git-gutter-mode))

(use-package git-gutter-fringe
  :straight t
  :config
  (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom))

(provide 'jpdl/magit)
;;; magit.el ends here
