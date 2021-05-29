;;; magit.el --- Summary

;;; Commentary:

;;; Code:

;; Magic handler for git
(use-package magit
  :bind
  ("C-x g" . magit-status)
  :config
  (use-package with-editor)
  (setq magit-push-always-verify nil)
  (setq git-commit-summary-max-length 50)
  
  ;; Start commit message in insert state.
  (add-hook 'with-editor-mode-hook 'evil-insert-state))

(use-package forge
  :after magit)

(provide 'jpdl/magit)
;;; magit.el ends here
