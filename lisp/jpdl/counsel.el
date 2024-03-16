;;; counsel.el --- Summary
;;; Commentary:

;;; Code:
(use-package counsel
  :straight t
  :init
  (setq counsel-mode t)
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-x 4 C-f" . (lambda () (interactive) (other-window-prefix) (counsel-find-file)))
         ("C-x C-b" . counsel-switch-buffer)
         ("C-x 4 C-b" . counsel-switch-buffer-other-window)
         ("C-x C-x" . counsel-buffer-or-recentf)
         (:map evil-normal-state-map
               ("SPC s f" . counsel-find-file)
               ("SPC 4 s f" . (lambda () (interactive) (other-window-prefix) (counsel-find-file)))
               ("SPC SPC" . counsel-M-x)))
  :chords (:map evil-normal-state-map
                ("SPCsf" . counsel-find-files)
                ("SPC4sf" . (lambda () (interactive) (other-window-prefix) (counsel-find-file)))))

(use-package smex
  :straight t
  :after counsel)

(use-package counsel-projectile
  :straight t
  :after (counsel)
  :bind (("C-x C-d" . counsel-projectile-find-file)
         ("C-x 4 d" . (lambda () (interactive) (other-window-prefix) (counsel-projectile-find-file)))
         ("C-x 4 C-d" . (lambda () (interactive) (other-window-prefix) (counsel-projectile-find-file)))
         ("C-x C-p" . counsel-projectile-switch-project)
         ("C-x 4 C-p" . (lambda () (interactive) (other-window-prefix) (counsel-projectile-switch-project)))
         ("C-x C-r" . counsel-projectile-rg)
         ("C-x 4 C-r" . (lambda () (interactive) (other-window-prefix) (counsel-projectile-rg)))
         (:map evil-normal-state-map
               ("SPC r g" . counsel-projectile-rg)
               ("SPC 4 r g" . (lambda () (interactive) (other-window-prefix) counsel-projectile-rg))
               ("SPC s d" . counsel-projectile-find-file)
               ("SPC 4 s d" . (lambda () (interactive) (other-window-prefix) (counsel-projectile-find-file)))))
  :chords (:map evil-normal-state-map
                ("SPCrg" . counsel-projectile-rg)
                ("SPC4rg" . (lambda () (interactive) (other-window-prefix) (counsel-projectile-rg)))
                ("SPCsd" . counsel-projectile-find-file)
                ("SPC4sd" . (lambda () (interactive) (other-window-prefix) (counsel-projectile-find-file)))))

(provide 'jpdl/counsel)
;;; counsel.el ends here
