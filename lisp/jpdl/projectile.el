;;; projectile.el --- Summary

;;; Commentary:

;;; Code:

;; Handle projects
(use-package projectile
  :config
  (projectile-mode 1)
  (setq projectile-project-search-path '("~/"))
  (setq projectile-completion-system 'helm)
  (which-key-add-key-based-replacements
    "C-c p 4" "other-window"
    "C-c p 5" "other-frame"
    "C-c p s" "search"
    "C-c p x" "execute")
  ;; Set frame title
  (setq frame-title-format '(concat ("emacs - ":eval (projectile-project-name))))
  (setq projectile-indexing-method 'alien)
  :bind-keymap ("C-c p" . projectile-command-map))

(use-package helm-projectile
  :after (helm projectile)
  :config (helm-projectile-on)
  :bind
  ("C-c C-f" . helm-projectile-find-other-file)
  ("C-c C-d" . helm-projectile-find-file))

(provide 'jpdl/projectile)
;;; projectile.el ends here
