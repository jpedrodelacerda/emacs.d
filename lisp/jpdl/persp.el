;;; persp.el --- Summary

;;; Commentary:

;;; Code:
(defun jpdl/create-or-switch-perspective (dir)
  (persp-switch (f-filename dir)))

(use-package perspective
  :straight t
  :after consult
  :general
  (:prefix "C-c C-w"
           "w" 'persp-switch
           "b" 'persp-switch-to-buffer*
           "k" 'persp-kill
           "r" 'persp-rename
           "s" 'persp-state-save
           "l" 'persp-state-load
           "<left>" 'persp-prev
           "<right>" 'persp-next)
  (jpdl/spc-leader
    "w w" 'persp-switch
    "w b" 'persp-switch-to-buffer*
    "w k" 'persp-kill
    "w r" 'persp-rename
    "w s" 'persp-state-save
    "w l" 'persp-state-load
    "w <left>" 'persp-prev
    "w <right>" 'persp-next)
  :hook
  (kill-emacs . persp-state-save)
  ;; (after-init . (lambda () (persp-state-load (concat user-emacs-directory "persp-save"))))
  :custom
  (persp-mode-prefix-key (kbd "C-c C-p"))
  (persp-state-default-file (concat user-emacs-directory "persp-save"))
  (persp-modestring-short nil)
  :config
  (advice-add 'project-switch-project :before #'jpdl/create-or-switch-perspective)
  ;; Inspired by <https://github.com/bbatsov/persp-projectile>
  (persp-mode t))

;; (use-package workgroups
;;   :straight t
;;   (jpdl/spc-leader
;;     "w" ')
;;  )


;; (use-package persp-mode
;;   :straight t
;;   :hook (window-setup . persp-mode)
;;   :general
;;   (jpdl/spc-leader
;;     "p b" 'persp-switch-to-buffer
;;     "p k" 'persp-kill-buffer))



;; (use-package persp-projectile
;;   :straight t
;;   :after (perspective projectile)
;;   :general
;;   ("C-x C-p" 'projectile-persp-switch-project)
;;   (jpdl/spc-leader
;;     "4 s p" '(lambda () (interactive) (other-window-prefix) (projectile-persp-switch-project))
;;     "s p" 'projectile-persp-switch-project
;;     "4 p s" '(lambda () (interactive) (other-window-prefix) (projectile-persp-switch-project))
;;     "p s" 'projectile-persp-switch-project))

(provide 'jpdl/persp)
;;; persp.el ends here
