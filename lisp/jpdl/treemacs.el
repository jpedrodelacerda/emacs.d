;;; treemacs.el --- Summary

;;; Commentary:
;; browse directories and projects

;;; Code:

(use-package treemacs
  :config
  (use-package treemacs-evil)
  (setq-local imenu-create-index-function #'ggtags-build-imenu-index)
  (setq treemacs-width 25)
  :bind ("M-v" . treemacs ))

(provide 'jpdl/treemacs)
;;; treemacs.el ends here
