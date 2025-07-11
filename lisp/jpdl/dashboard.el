;;; dashboard.el --- Summary  -*- lexical-binding: t; -*-
;;; Commentary:

;;; Code:
(use-package dashboard
  :straight t
  :hook (server-after-make-frame . dashboard-refresh-buffer)
  :init (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  :config
  (setq dashboard-startup-banner (concat (concat "/home/" user-login-name) "/emacs.d/enso.png"))
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-navigation-cycle t)
  (add-to-list 'dashboard-items '(agenda) t)
  (setq dashboard-projects-backend 'project-el)
  (setq dashboard-projects-switch-function 'project-switch-project)
  (setq show-week-agenda-p t)
                                        ;(setq recentf-exclude (org-agenda-files))
  (setq dashboard-items '(
                          (recents  . 5)
                          (projects . 5)
                          (bookmarks . 5)))
  (dashboard-setup-startup-hook))

(provide 'jpdl/dashboard)
;;; dashboard.el ends here
