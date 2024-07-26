;;; counsel.el --- Summary
;;; Commentary:

;;; Code:
(use-package counsel
  :straight t
  :init
  (setq counsel-mode t)
  :general
  ("M-x" 'counsel-M-x
   "C-x C-f" 'counsel-find-file
   "C-x 4 C-f" '((lambda)  (interactive) other-window-prefix counsel-find-file)
   "C-x C-b" 'counsel-switch-buffer
   "C-x 4 C-b" 'counsel-switch-buffer-other-window
   "C-x C-x" 'counsel-buffer-or-recentf)
  (jpdl/spc-leader
    "s f" 'counsel-find-file
    "s b" 'counsel-switch-buffer
    "x x" 'counsel-buffer-or-recentf
    "4 s f" '(lambda () (interactive) (other-window-prefix) (counsel-find-file))
    "4 s b" '(lambda () (interactive) (other-window-prefix) (counsel-switch-buffer))
    "SPC" 'counsel-M-x)
  :config
  (defun counsel--load-theme-action (x)
    "Disable current themes and load theme X."
    (condition-case nil
        (progn
          (mapc #'disable-theme custom-enabled-themes)
          (load-theme (intern x) t)
          (run-hooks 'load-theme-hook))
      (error "Problem loading theme %s" x)))

  (defun counsel--update-theme-action ()
    "Change theme to selected."
    (counsel--load-theme-action (ivy-state-current ivy-last)))

  (defun counsel-load-theme ()
    "Forward to `load-theme'."
    (interactive)
    (let ((curr-theme (when custom-enabled-themes
                        (car custom-enabled-themes))))
      (ivy-read "Load custom theme: "
                (mapcar 'symbol-name (custom-available-themes))
                :action #'counsel--load-theme-action
                :preselect (symbol-name curr-theme)
                :update-fn #'counsel--update-theme-action
                ))))

(use-package smex
  :straight t
  :after counsel)

(use-package counsel-projectile
  :straight t
  :after (counsel)
  :general
  ("C-x C-d" 'counsel-projectile-find-file
   "C-x 4 d" '(lambda () (interactive) (other-window-prefix) (counsel-projectile-find-file))
   "C-x 4 C-d" '(lambda () (interactive) (other-window-prefix) (counsel-projectile-find-file))
   "C-x C-p" 'counsel-projectile-switch-project
   "C-x 4 C-p" '(lambda () (interactive) (other-window-prefix) (counsel-projectile-switch-project))
   "C-x C-r" 'counsel-projectile-rg
   "C-x 4 C-r" '(lambda () (interactive) (other-window-prefix) (counsel-projectile-rg))
   (jpdl/spc-leader
     "r g" 'counsel-projectile-rg
     "4 r g" '(lambda () (interactive) (other-window-prefix) counsel-projectile-rg)
     "s d" 'counsel-projectile-find-file
     "4 s d" '(lambda () (interactive) (other-window-prefix) (counsel-projectile-find-file)))))

(provide 'jpdl/counsel)
;;; counsel.el ends here
