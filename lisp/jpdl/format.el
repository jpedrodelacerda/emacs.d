;;; format.el --- summary -*- lexical-binding: t -*-

;;; Commentary:

;; commentary

;;; Code:

(use-package apheleia
  :straight t
  :hook
  (after-init . apheleia-global-mode)
  (before-save . jpdl/format-buffer)
  :general
  ("C-c C-f" 'jpdl/format-buffer)
  (jpdl/spc-leader
    "f f" 'jpdl/format-buffer
    "l f" 'jpdl/format-buffer)
  :config
  (defun jpdl/get-formatter-backend ()
    "Returns an appropriate backend for formatting the current buffer.

Will return one of the following symbols:
- apheleia
- eglot
"
    (interactive)
    (or (when
            (let* ((aph-func (cdr (assoc major-mode apheleia-mode-alist)))
                   (aph-func-int (cdr (assoc aph-func apheleia-formatters))))
              (and
               apheleia-mode
               aph-func
               (pcase aph-func-int
                 ((pred atom)  (fboundp aph-func-int))
                 ((pred listp) (executable-find (car aph-func-int))))))
          'apheleia)
        (when (and (fboundp #'eglot-managed-p)
                   (eglot-managed-p)
                   (not
                    (member :documentFormattingProvider
                            eglot-ignored-server-capabilities)))
          'eglot)
        (when (and (treesit-available-p)
                   (string-match "*-ts-*" (symbol-name major-mode))))))

  (defun jpdl/format-buffer (&optional formatter)
    "My custom format-buffer command. Integrates w/ Apheleia, Eglot & -TS- modes.

The heirarchy is as follows:
- `apheleia-format-buffer'
- `eglot-format-buffer'

Additionally, any of these functions can be requested explicity, by providing
FORMATTER as the optional argument. FORMATTER is expected to be one of the
following symbols:
- \\='apheleia
- \\='eglot

It will also remove any trailing whitespace from the end of any line from
the file.
"
    (interactive)
    (setq formatter
          (if (not (eq nil formatter)) formatter (jpdl/get-formatter-backend)))
    (cl-flet
        ((apheleia-fmt ()
           (apheleia-format-buffer (cdr (assoc major-mode apheleia-mode-alist))))
         (eglot-fmt ()
           (eglot-format-buffer)))
      ;; (eglot-fmt ()
      ;;   (eglot-format (point-min) (point-max))))
      (pcase formatter
        ('apheleia (apheleia-fmt))
        ('eglot    (eglot-fmt))
        (delete-trailing-whitespace (point-min) (point-max))))))

;; FIXME: seems to have strange behavior at times...
;; (advice-add
;;  #'apheleia-format-after-save
;;  :around
;;  (lambda (orig &rest args)
;;    "Use my custom format-buffer command if applicable"
;;    (let ((formatter (jpdl/get-formatter-backend)))
;;      (cond
;;       ((boundp 'jpdl/apheleia-preferred-backend)
;;        (jpdl/format-buffer jpdl/apheleia-preferred-backend))
;;       ((not (eq 'apheleia formatter))
;;        (jpdl/format-buffer formatter))
;;       (t (apply orig args)))))))


(provide 'jpdl/format)
;;; format.el ends here
