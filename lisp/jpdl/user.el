;;; user.el --- Summary

;;; Commentary:

;;; Code:

(setq home (concat "/home/" (eval user-login-name)))

;; Auth
(setq auth-sources '("~/.authinfo"))

(provide 'jpdl/user)
;;; user.el ends here
