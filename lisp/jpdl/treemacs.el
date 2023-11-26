;;; treemacs.el --- Summary

;;; Commentary:
;; browse directories and projects

;;; Code:

(use-package treemacs
  :config
  (use-package treemacs-evil)
  (use-package treemacs-magit)
  (use-package treemacs-tab-bar)
  (use-package treemacs-all-the-icons)
  (use-package treemacs-projectile)
  (setq treemacs-git-commit-diff-mode 1)
  (setq treemacs-display-current-project-exclusively t)
  (setq treemacs-project-follow-mode t)
  (setq-local imenu-create-index-function #'ggtags-build-imenu-index)
  (setq treemacs-width 25)
  (setq treemacs-persist-file (expand-file-name ".cache/treemacs-persist" user-emacs-directory))
  (add-hook 'projectile-after-switch-project-hook 'treemacs-display-current-project-exclusively)
  :bind ("M-v" . treemacs)
        (:map treemacs-mode-map)
        ("S-<up>" . treemacs-move-project-up)
        ("S-<down>" . treemacs-move-project-down))

(provide 'jpdl/treemacs)
;;; treemacs.el ends here
