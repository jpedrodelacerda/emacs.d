;;; tempel.el --- Summary
;;; Commentary:

;;; Code:
;; Configure Tempel
(use-package tempel
  ;; Require trigger prefix before template name when completing.
  :custom
  (tempel-trigger-prefix "<")
  ;; :bind (("M-+" . tempel-complete) ;; Alternative tempel-expand
  ;;        ("M-*" . tempel-insert))
  :hook
  (prog-mode . tempel-abbrev-mode)
  (conf-mode . tempel-setup-capf)
  (prog-mode . tempel-setup-capf)
  (text-mode . tempel-setup-capf)
  :init
  ;; Setup completion at point
  (defun tempel-setup-capf ()
    ;; Add the Tempel Capf to `completion-at-point-functions'.
    ;; `tempel-expand' only triggers on exact matches. Alternatively use
    ;; `tempel-complete' if you want to see all matches, but then you
    ;; should also configure `tempel-trigger-prefix', such that Tempel
    ;; does not trigger too often when you don't expect it. NOTE: We add
    ;; `tempel-expand' *before* the main programming mode Capf, such
    ;; that it will be tried first.
    (setq-local completion-at-point-functions
                (cons #'tempel-expand
                      completion-at-point-functions)))
  (global-tempel-abbrev-mode))

;; Optional: Add tempel-collection.
;; The package is young and doesn't have comprehensive coverage.
(use-package tempel-collection)

(provide 'jpdl/tempel)
;;; tempel.el ends here
