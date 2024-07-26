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

(use-package general
  :straight t
  :config
  (general-evil-setup)
  (general-create-definer jpdl/spc-leader
    :states '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC"))

;; Booting
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'jpdl/font)
(require 'jpdl/system)
(require 'jpdl/theme)
(require 'jpdl/dashboard)
(require 'jpdl/evil)
(require 'jpdl/user)
(require 'jpdl/projectile)
(require 'jpdl/treemacs)
(require 'jpdl/persp)
(require 'jpdl/counsel)
(require 'jpdl/ivy)
(require 'jpdl/org)
(require 'jpdl/obsidian)
(require 'jpdl/lsp)
(require 'jpdl/tabs)
(require 'jpdl/nav)
(require 'jpdl/pairs)
(require 'jpdl/magit)
(require 'jpdl/company)
(require 'jpdl/lsp)
(require 'jpdl/debug)
(require 'jpdl/flycheck)
(require 'jpdl/ux)
(require 'jpdl/prog)

(provide 'init.el)
;;; init.el ends here
