;;; helm.el --- Summary

;;; Commentary:

;;; Code:

;; Helm
(use-package helm
  :config
  (helm-autoresize-mode 1)
  (setq helm-autoresize-min-height 25)
  (setq helm-autoresize-max-height 35)
  ;; Ignore some files
  (setq helm-ff-skip-boring-files t)
  (setq helm-ff-skip-git-ignored-files t)

  ;; bindings
  (define-key helm-map (kbd "TAB") #'helm-execute-persistent-action)
  (define-key helm-map (kbd "<tab>") #'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z") #'helm-select-action)
  :bind (("C-x C-b" . helm-mini)
	 ("C-x C-f" . helm-find-files)
	 ("C-x 4 C-f" . helm-ff-find-file-other-tab)
	 ("C-x 4 f" . helm-ff-find-file-other-tab)))


(provide 'jpdl/helm)
;;; helm.el ends here
