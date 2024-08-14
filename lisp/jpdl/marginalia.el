;;; marginalia.el --- Summary
;;; Commentary:

;;; Code:

(use-package marginalia
  :straight t
  :general
  (:map 'minibuffer-local-map
        "M-m" 'marginalia-cycle)
  ("M-x" 'execute-extended-command)
  (jpdl/spc-leader
    "SPC" 'execute-extended-command)
  :custom
  (marginalia-max-relative-age 0)
  (marginalia-align 'center)
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode)
  :config
  (defun marginalia-annotate-alias (cand)
    "Annotate CAND with the function it aliases."
    (when-let ((sym (intern-soft cand))
               (alias (car (last (function-alias-p sym t))))
               (name (and (symbolp alias) (symbol-name alias))))
      (format #(" (%s)" 1 5 (face marginalia-function)) name)))
  (defun marginalia-annotate-command-with-alias (cand)
    "Annotate command CAND with its documentation string.
    Similar to `marginalia-annotate-symbol', but does not show symbol class."
    (when-let (sym (intern-soft cand))
      (concat
       (marginalia-annotate-binding cand)
       (marginalia-annotate-alias cand)
       (marginalia--documentation (marginalia--function-doc sym)))))
  (cl-pushnew #'marginalia-annotate-command-with-alias
              (alist-get 'command marginalia-annotator-registry)))

(use-package savehist
  :straight t
  :init
  (savehist-mode +1))

(use-package all-the-icons-completion
  :straight t
  :after (marginalia all-the-icons)
  :hook (marginalia-mode . all-the-icons-completion-marginalia-setup)
  :init
  (all-the-icons-completion-mode))


(provide 'jpdl/marginalia)
;;; marginalia.el ends here
