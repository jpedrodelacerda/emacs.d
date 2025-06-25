;;; user.el --- Summary  -*- lexical-binding: t; -*-

;;; Commentary:

;;; code:

(setq home (concat "/home/" (eval user-login-name)))

;; Auth
(setq auth-sources '("~/.authinfo"))

(provide 'jpdl/user)
;;; user.el ends here
