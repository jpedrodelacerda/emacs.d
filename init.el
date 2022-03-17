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

;; If use-package isn't already installed, it's extremely likely that this is a
;; fresh installation! So we'll want to update the package repository and
;; install use-package before loading the literate configuration.
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t)

;; Booting
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'jpdl/theme)
(require 'jpdl/dashboard)
(require 'jpdl/system)
(require 'jpdl/font)
(require 'jpdl/evil)
(require 'jpdl/user)
(require 'jpdl/ivy)
(require 'jpdl/helm)
(require 'jpdl/org)
(require 'jpdl/agenda)
(require 'jpdl/lsp)
(require 'jpdl/tabs)
(require 'jpdl/nav)
(require 'jpdl/smartparens)
(require 'jpdl/magit)
(require 'jpdl/company)
(require 'jpdl/lsp)
(require 'jpdl/flycheck)
(require 'jpdl/treemacs)
(require 'jpdl/projectile)
(require 'jpdl/ux)
(require 'jpdl/prog)

(provide 'init.el)
;;; init.el ends here
