(use-package dashboard
  :straight t
  :init (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  :config
  (setq dashboard-startup-banner (concat (concat "/home/" user-login-name) "/emacs.d/enso.png"))
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (add-to-list 'dashboard-items '(agenda) t)
  (setq show-week-agenda-p t)
  ;(setq recentf-exclude (org-agenda-files))
  (setq dashboard-items '(
                        (recents  . 5)
                        (projects . 5)
                        (bookmarks . 5)))
  (dashboard-setup-startup-hook))

(provide 'jpdl/dashboard)
