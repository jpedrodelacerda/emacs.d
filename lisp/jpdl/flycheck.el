;;; flycheck.el --- Summary:

;;; Commentary:

;;; Code:

;; Checking for errors
(use-package flycheck
  :config
  (global-flycheck-mode))

(use-package flycheck-color-mode-line
  :after (flycheck)
  :hook (flycheck-mode-hook . flycheck-color-mode-line-mode))
;; (eval-after-load "flycheck"
;;   '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

(provide 'jpdl/flycheck)
;;; flycheck.el ends here
