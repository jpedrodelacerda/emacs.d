;;; helm.el --- Summary

;;; Commentary:

;;; Code:

;; Helm
(use-package helm
  :config
  (helm-autoresize-mode 1)
  (setq helm-autoresize-min-height 25)
  (setq helm-autoresize-max-height 35)
  (define-key helm-map (kbd "TAB") #'helm-execute-persistent-action)
  (define-key helm-map (kbd "<tab>") #'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z") #'helm-select-action)
  :bind (("C-x C-b" . helm-mini)
	     ;; ("C-x C-f" . helm-find-files)
	     ("C-x C-d" . helm-projectile-find-file)))

(provide 'jpdl/helm)
;;; helm.el ends here
