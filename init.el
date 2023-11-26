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

(setq use-package-always-ensure t)

;; Booting
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'jpdl/font)
(require 'jpdl/system)
(require 'jpdl/theme)
(require 'jpdl/dashboard)
(require 'jpdl/evil)
(require 'jpdl/user)
(require 'jpdl/counsel)
(require 'jpdl/ivy)
(require 'jpdl/org)
(require 'jpdl/obsidian)
(require 'jpdl/agenda)
(require 'jpdl/lsp)
(require 'jpdl/tabs)
(require 'jpdl/term)
(require 'jpdl/nav)
(require 'jpdl/smartparens)
(require 'jpdl/magit)
(require 'jpdl/company)
(require 'jpdl/lsp)
(require 'jpdl/debug)
(require 'jpdl/flycheck)
(require 'jpdl/treemacs)
(require 'jpdl/projectile)
(require 'jpdl/ux)
(require 'jpdl/prog)

(provide 'init.el)
;;; init.el ends here
