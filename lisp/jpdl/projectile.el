;;; projectile.el --- Summary

;;; Commentary:

;;; Code:

;; Handle projects
(use-package projectile
  :straight t
  :config
  (projectile-mode 1)
  (setq projectile-project-search-path '("~/dotfiles" "~/dotnix" "~/projetos"))
  (setq projectile-completion-system 'ivy)
  (which-key-add-key-based-replacements
    "C-c p 4" "other-window"
    "C-c p 5" "other-frame"
    "C-c p s" "search"
    "C-c p x" "execute")
  ;; Set frame title
  (setq frame-title-format '(concat ("emacs - ":eval (projectile-project-name))))
  (setq projectile-indexing-method 'alien)
  :bind-keymap ("C-c p" . projectile-command-map)
  :general
  ("C-x C-v" 'projectile-find-file-in-known-projects
   "C-x 4 C-v" '(lambda () (interactive) (other-window-prefix) (projectile-find-file-in-known-projects))
   (jpdl/spc-leader
     "s v" 'projectile-find-file-in-known-projects
     "4 s v" '(lambda () (interactive) (other-window-prefix) (projectile-find-file-in-known-projects)))))

(provide 'jpdl/projectile)
;;; projectile.el ends here
