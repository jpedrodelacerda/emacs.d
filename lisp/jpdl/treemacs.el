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
  (treemacs-git-commit-diff-mode 1)
  (setq-local imenu-create-index-function #'ggtags-build-imenu-index)
  (setq treemacs-width 25)
  (add-hook 'projectile-after-switch-project-hook 'treemacs-display-current-project-exclusively)
  :bind ("M-v" . treemacs )
        (:map treemacs-mode-map)
        ("S-<up>" . treemacs-move-project-up)
        ("S-<down>" . treemacs-move-project-down))

(provide 'jpdl/treemacs)
;;; treemacs.el ends here
