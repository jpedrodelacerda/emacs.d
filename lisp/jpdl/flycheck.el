;;; flycheck.el --- Summary:

;;; Commentary:

;;; Code:

;; Checking for errors
(use-package flycheck
  :straight t
  :config
  (setq flycheck-emacs-lisp-load-path 'inherit)
  (global-flycheck-mode))

(use-package flycheck-color-mode-line
  :straight t
  :after (flycheck)
  :hook (flycheck-mode-hook . flycheck-color-mode-line-mode))
;; (eval-after-load "flycheck"
;;   '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

(provide 'jpdl/flycheck)
;;; flycheck.el ends here
