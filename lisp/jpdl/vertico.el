;;; vertico.el --- Summary  -*- lexical-binding: t; -*-
;;; Commentary:

;;; Code:

(use-package vertico
  :straight (:files (:defaults "extensions/*.el"))
  :hook
  (rfn-eshadow-update-overlay . vertico-directory-tidy)
  :general
  (:keymaps '(vertico-map vertico-multiform-map)
            "M-n" 'next-history-element
            "M-p" 'previous-history-element
            "C-n" 'vertico-next
            "C-p" 'vertico-previous
            "C-M-n" 'vertico-next-group
            "C-M-p" 'vertico-previous-group
            "C-x C-f" 'project-find-file)
  :custom
  (vertico-count 20)
  (vertico-resize nil)
  (vertico-cycle t)
  (enable-recursive-minibuffers t)
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; :custom
  ;; (vertico-multiform-commands
  ;;  '((consult-imenu buffer indexed)
  ;;    (consult-ripgrep buffer indexed)))
  ;; (vertico-multiform-categories
  ;;  '((file grid)
  ;;    (consult-grep vertical)
  ;;    (consult-ripgrep vertical)))
  :init
  (vertico-mode)
  (vertico-multiform-mode)
  :config
  (defvar +vertico-transform-functions nil)
  (cl-defmethod vertico--format-candidate :around
    (cand prefix suffix index start &context ((not +vertico-transform-functions) null))
    (dolist (fun (ensure-list +vertico-transform-functions))
      (setq cand (funcall fun cand)))
    (cl-call-next-method cand prefix suffix index start))

  (defun +vertico-highlight-directory (file)
    "If FILE ends with a slash, highlight it as a directory."
    (if (string-suffix-p "/" file)
        (propertize file 'face 'marginalia-file-priv-dir) ; or face 'dired-directory
      file))

  ;; function to highlight enabled modes similar to counsel-M-x
  (defun +vertico-highlight-enabled-mode (cmd)
    "If MODE is enabled, highlight it as font-lock-constant-face."
    (let ((sym (intern cmd)))
      (if (or (eq sym major-mode)
              (and
               (memq sym minor-mode-list)
               (boundp sym)))
          (propertize cmd 'face 'font-lock-constant-face)
        cmd)))

  (setq vertico-multiform-commands
        '((execute-extended-command
           posframe
           (+vertico-transform-functions . +vertico-highlight-enabled-mode))
          (t posframe)))
  (setq vertico-multiform-categories
        '((file
           ;; this is also defined in the wiki, uncomment if used
           ;; (vertico-sort-function . sort-directories-first)
           (+vertico-transform-functions . +vertico-highlight-directory)))))

(use-package posframe
  :straight t)

(use-package vertico-posframe
  :straight t
  :after (vertico)
  :general
  (:keymaps '(vertico-map vertico-multiform-map)
            "M-p" 'previous-history-element
            "M-P" 'vertico-multiform-posframe)
  :config
  (setq vertico-posframe-poshandler 'posframe-poshandler-frame-center
        vertico-posframe-width 140
        vertico-posframe-height 20
        ;; vertico-posframe-border-width 2
        vertico-posframe-parameters '(
                                      (left-fringe . 8)
                                      (right-fringe . 8)))
  (vertico-posframe-mode 1))

(provide 'jpdl/vertico)
;;; vertico.el ends here
