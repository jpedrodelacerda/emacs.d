(setq default-font "Fira Code")
(setq default-font-size 10)
(setq current-font-size default-font-size)

(setq font-change-increment 1.1)

(defun font-code ()
  "Return a string representing the current font (like \"Inconsolata-14\")."
  (concat default-font "-" (number-to-string current-font-size)))

(defun set-font-size ()
  "Set the font to `default-font' at `current-font-size'.
Set that for the current frame, and also make it the default for
other, future frames."
  (let ((font-code (font-code)))
    (add-to-list 'default-frame-alist (cons 'font font-code))
    (set-frame-font font-code)))

(defun reset-font-size ()
  "Change font size back to `default-font-size'."
  (interactive)
  (setq current-font-size default-font-size)
  (set-font-size))

(defun increase-font-size ()
  "Increase current font size by a factor of `font-change-increment'."
  (interactive)
  (setq current-font-size
        (ceiling (* current-font-size font-change-increment)))
  (set-font-size))

(defun decrease-font-size ()
  "Decrease current font size by a factor of `font-change-increment', down to a minimum size of 1."
  (interactive)
  (setq current-font-size
        (max 1
             (floor (/ current-font-size font-change-increment))))
  (set-font-size))

(define-key global-map (kbd "C-)") 'reset-font-size)
(define-key global-map (kbd "C-+") 'increase-font-size)
(define-key global-map (kbd "C-=") 'increase-font-size)
(define-key global-map (kbd "C-_") 'decrease-font-size)
(define-key global-map (kbd "C--") 'decrease-font-size)

;; Enable the www ligature in every possible major mode
(use-package ligature
  :straight t
  :config
  (ligature-set-ligatures 't '("www"))
  ;; Enable ligatures in programming modes
  (ligature-set-ligatures 'prog-mode '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\" "{-" "::"
                                     ":::" ":=" "!!" "!=" "!==" "-}" "----" "-->" "->" "->>"
                                     "-<" "-<<" "-~" "#{" "#[" "##" "###" "####" "#(" "#?" "#_"
                                     "#_(" ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*" "/**"
                                     "/=" "/==" "/>" "//" "///" "&&" "||" "||=" "|=" "|>" "^=" "$>"
                                     "++" "+++" "+>" "=:=" "==" "===" "==>" "=>" "=>>" "<="
                                     "=<<" "=/=" ">-" ">=" ">=>" ">>" ">>-" ">>=" ">>>" "<*"
                                     "<*>" "<|" "<|>" "<$" "<$>" "<!--" "<-" "<--" "<->" "<+"
                                     "<+>" "<=" "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<"
                                     "<~" "<~~" "</" "</>" "~@" "~-" "~>" "~~" "~~>" "%%"))
  (global-ligature-mode 't))

;; (load "~/emacs.d/fira-code-ligatures.el")
(reset-font-size)
(provide 'jpdl/font)
