;;; persp.el --- Summary

;;; Commentary:

;;; Code:

(use-package perspective
  :straight t
  :after (counsel)
  :general
  (jpdl/spc-leader
    "p b" 'persp-counsel-switch-buffer
    "p k" 'persp-kill)
  :hook (kill-emacs-hook . persp-save-state)
  :custom (persp-mode-prefix-key (kbd "C-c C-p"))
  :config
  (persp-mode t)
  (setq persp-modestring-short nil))


(use-package persp-projectile
  :straight t
  :after (perspective projectile)
  :general
  ("C-x C-p" 'projectile-persp-switch-project)
  (jpdl/spc-leader
    "s p" 'projectile-persp-switch-project))

(provide 'jpdl/persp)
;;; persp.el ends here
