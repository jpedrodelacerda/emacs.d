;;; package -- Summary:

;;; Commentary:
;; I'm too lazy for this shit.

;;; Code:

;; Load custom-file
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'no-error 'no-message)

;; Configure package.el to include MELPA.
(require 'package)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(package-initialize)

;; Ensure that use-package is installed.

(eval-when-compile
  (require 'use-package))

;; Bootstrap straight
(setq straight-use-package-by-default t)
(setq use-package-always-demand t)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Booting
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'jpdl/general)
(require 'jpdl/font)
(require 'jpdl/system)
(require 'jpdl/theme)
;;(require 'jpdl/dashboard)
(require 'jpdl/evil)
(require 'jpdl/org)
(require 'jpdl/user)
(require 'jpdl/project)
(require 'jpdl/treemacs)
(require 'jpdl/persp)
(require 'jpdl/vertico)
(require 'jpdl/orderless)
(require 'jpdl/marginalia)
(require 'jpdl/consult)
(require 'jpdl/embark)
(require 'jpdl/term)
(require 'jpdl/lsp)
(require 'jpdl/tabs)
(require 'jpdl/nav)
(require 'jpdl/pairs)
(require 'jpdl/magit)
(require 'jpdl/corfu)
(require 'jpdl/tempel)
(require 'jpdl/lsp)
(require 'jpdl/debug)
(require 'jpdl/flycheck)
(require 'jpdl/ux)
(require 'jpdl/prog)
;; (require 'jpdl/calibre)

(provide 'init.el)
;;; init.el ends here
