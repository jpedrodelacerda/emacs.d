;;; system.el --- Summary
;;; Commentary:

;;; Code:

(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode +1)
  (setq centaur-tabs-set-bar 'under)
  (setq x-underline-at-descent-line t)
  (centaur-tabs-headline-match)
  (setq centaur-tabs-style "wave"
        centaur-tabs-set-modified-marker t
        centaur-tabs-modified-marker " ● "
        centaur-tabs-cycle-scope 'tabs
        centaur-tabs-height 30
        centaur-tabs-set-icons t
        ;; centaur-tabs-show-navigation-buttons t
        centaur-tabs-close-button "  ")
  (centaur-tabs-group-by-projectile-project)
  (setq centaur-tabs-cycle-scope 'tabs)
  :bind
  ;; ("<C-S-tab>" . centaur-tabs-backward)
  ("C-<iso-lefttab>" . centaur-tabs-backward)
  ("C-<tab>" . centaur-tabs-forward)
  ("C-w" . kill-buffer)
  ("C-c C-<left>" . centaur-tabs-move-current-tab-to-left)
  ("C-c C-<right>" . centaur-tabs-move-current-tab-to-right))

(provide 'jpdl/tabs)
;;; tabs.el ends here
