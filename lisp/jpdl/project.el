;;; project.el --- Summary

;;; Commentary:

;;; Code:

;; ;; Handle projects
;; (use-package projectile
;;   :straight t
;;   :config
;;   (projectile-mode 1)
;;   (setq projectile-project-search-path '("~/dotfiles" "~/dotnix" "~/projetos"))
;;   (setq projectile-completion-system 'default)
;;   (which-key-add-key-based-replacements
;;     "C-c p 4" "other-window"
;;     "C-c p 5" "other-frame"
;;     "C-c p s" "search"
;;     "C-c p x" "execute")
;;   ;; Set frame title
;;   (setq frame-title-format '(concat ("emacs - ":eval (projectile-project-name))))
;;   (setq projectile-indexing-method 'alien)
;;   :bind-keymap ("C-c p" . projectile-command-map)
;;   :general
;;   ("C-x C-v" 'projectile-find-file-in-known-projects
;;    "C-x 4 C-v" '(lambda () (interactive) (other-window-prefix) (projectile-find-file-in-known-projects))
;;    "C-x C-d" 'projectile-find-file
;;    "C-x 4 C-d" '(lambda () (interactive) (other-window-prefix) (projectile-find-file))
;;    (jpdl/spc-leader
;;      "p a" 'projectile-add-known-project
;;      "s d" 'projectile-find-file
;;      "4 s d" '(lambda () (interactive) (other-window-prefix) (projectile-find-file))
;;      "s v" 'projectile-find-file-in-known-projects
;;      "4 s v" '(lambda () (interactive) (other-window-prefix) (projectile-find-file-in-known-projects)))))

(use-package project
  :straight (:type built-in)
  :general
  (jpdl/spc-leader
    "s p" 'project-switch-project
    "4 s p" '(lambda () (interactive) (other-window-prefix) (project-switch-project))
    "p s" 'project-switch-project
    "4 p s" '(lambda () (interactive) (other-window-prefix) (project-switch-project))))

(provide 'jpdl/project)
;;; project.el ends here
