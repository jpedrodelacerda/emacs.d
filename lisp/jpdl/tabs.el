;;; system.el --- Summary
;;; Commentary:

;;; Code:

(use-package centaur-tabs
  :demand
  :init (setq centaur-tabs-set-bar 'over)
  :config
  (centaur-tabs-mode +1)
  (centaur-tabs-headline-match)
  (setq centaur-tabs-set-modified-marker t
        centaur-tabs-modified-marker " ● "
        centaur-tabs-cycle-scope 'tabs
        centaur-tabs-height 30
        centaur-tabs-set-icons t
        centaur-tabs-close-button " x ")
  (centaur-tabs-group-by-projectile-project)
  (setq centaur-tabs-cycle-scope 'tabs)
  :bind
  ;; ("<C-S-tab>" . centaur-tabs-backward)
  ("C-<iso-lefttab>" . centaur-tabs-backward)
  ("C-<tab>" . centaur-tabs-forward)
  ("C-w" . kill-buffer))

(provide 'jpdl/tabs)
;;; tabs.el ends here
