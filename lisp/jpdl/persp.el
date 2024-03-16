;;; persp.el --- Summary

;;; Commentary:

;;; Code:

(use-package perspective
  :straight t
  :after (counsel)
  :bind (("C-x k" . persp-kill)
         ("C-x b" . persp-counsel-switch-buffer)
         :map evil-normal-state-map
         ("SPC s b" . persp-counsel-switch-buffer))
  :chords ("SPCsb" . persp-counsel-switch-buffer)
  :hook (kill-emacs-hook . persp-save-state)
  :custom (persp-mode-prefix-key (kbd "C-c C-p"))
  :config
  (persp-mode t)
  (setq persp-modestring-short nil))


(use-package persp-projectile
  :straight t
  :after (perspective projectile)
  :bind (("C-x C-p" . projectile-persp-switch-project)
         :map evil-normal-state-map
         ("SPC s p" . projectile-persp-switch-project))
  :chords ("SPCsp" . projectile-persp-switch-project))

(provide 'jpdl/persp)
;;; persp.el ends here
