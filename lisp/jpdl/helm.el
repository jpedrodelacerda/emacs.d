;;; helm.el --- Summary

;;; Commentary:

;;; Code:

;; Helm
(use-package helm
  :demand t
  :config
  (use-package helm-rg)
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
	     ("C-x 4 C-f" . jpdl/helm-ff-other-window)
	     ("C-x 4 f" . jpdl/helm-ff-other-window)
         (:map evil-normal-state-map
               ("SPC s f" . helm-find-files)))
  :chords (:map evil-normal-state-map
                ("SPCsf" . helm-find-files)))


(defun jpdl/helm-ff-other-window ()
  "Execute helm-find-file with 'other window' as default action."
  (interactive)
  (jpdl/helm-ff-custom-default-action "Find file other window `C-c o'" 'helm-find-files-other-window))

(defun jpdl/helm-ff-custom-default-action (MSG ACTION)
  "Call 'helm-find-files' with custom default action.
MSG: action identifier
ACTION: function to be activated"
  (let
      ( (helm-find-files-actions (append (list (cons MSG ACTION)) helm-find-files-actions)) )
    (helm-find-files-1 "./")))

(provide 'jpdl/helm)
;;; helm.el ends here
