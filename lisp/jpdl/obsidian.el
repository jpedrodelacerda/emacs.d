;;; obsidian.el --- Summary

;;; Commentary:

;;; Code:

(use-package obsidian
  :ensure t
  :demand t
  :config
  (obsidian-specify-path "~/personal-notes")
  (global-obsidian-mode t)
  :custom
  ;; This directory will be used for `obsidian-capture' if set.
  (obsidian-inbox-directory "Inbox")
  :bind (:map obsidian-mode-map
  ;; Replace C-c C-o with Obsidian.el's implementation. It's ok to use another key binding.
  ("C-c C-o f" . obsidian-follow-link-at-point)
  ;; Jump to backlinks
  ("C-c C-o b" . obsidian-backlink-jump)
  ;; If you prefer you can use `obsidian-insert-link'
  ("C-c C-o l" . obsidian-insert-wikilink)))

(provide 'jpdl/obsidian)
;;; org.el ends here
