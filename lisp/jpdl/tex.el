;;; tex.el --- Summary  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(use-package auctex
  :straight auctex)

(use-package tex
  :straight auctex)

(use-package latex
  :after tex
  :straight auctex)

(use-package tex-site
  :straight auctex
  :mode ("\\.tex\\'" . latex-mode)
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (rainbow-delimiters-mode)
              (company-mode)
              (smartparens-mode)
              (turn-on-reftex)
              (setq reftex-plug-into-AUCTeX t)
              (reftex-isearch-minor-mode)
              (setq TeX-PDF-mode t)
              (setq TeX-source-correlate-method 'synctex)
              (setq TeX-source-correlate-start-server t)))

  ;; Update PDF buffers after successful LaTeX runs
  (add-hook 'TeX-after-TeX-LaTeX-command-finished-hook
            #'TeX-revert-document-buffer)

  ;; to use pdfview with auctex
  (add-hook 'LaTeX-mode-hook 'pdf-tools-install)

  ;; to use pdfview with auctex
  (setq TeX-view-program-selection '((output-pdf "pdf-tools"))
        TeX-source-correlate-start-server t)
  (setq TeX-view-program-list '(("pdf-tools" "TeX-pdf-tools-sync-view"))))

(use-package cdlatex
  :straight t
  :hook
  (LaTeX-mode . turn-on-cdlatex)
  (org-mode . turn-on-org-cdlatex)
  ;; :general
  ;; (:keymaps '(cdlatex-mode-map)
  ;;           "<tab>" . cdlatex-tab))
  :config
  (setq cdlatex-math-symbol-prefix ?\;)
  (define-key cdlatex-mode-map
              (cdlatex-get-kbd-vector cdlatex-math-symbol-prefix)
              #'cdlatex-math-symbol)
  (dolist (cmd '(("vc" "Insert \\vect{}" "\\vect{?}"
                  cdlatex-position-cursor nil nil t)
                 ("tfr" "Insert \\tfrac{}{}" "\\tfrac{?}{}"
                  cdlatex-position-cursor nil nil t)
                 ("sfr" "Insert \\sfrac{}{}" "\\sfrac{?}{}"
                  cdlatex-position-cursor nil nil t)
                 ("abs" "Insert \\abs{}" "\\abs{?}"
                  cdlatex-position-cursor nil nil t)
                 ("equ*" "Insert equation* env"
                  "\\begin{equation*}\n?\n\\end{equation*}"
                  cdlatex-position-cursor nil t nil)
                 ("sn*" "Insert section* env"
                  "\\section*{?}"
                  cdlatex-position-cursor nil t nil)
                 ("ss*" "Insert subsection* env"
                  "\\subsection*{?}"
                  cdlatex-position-cursor nil t nil)
                 ("sss*" "Insert subsubsection* env"
                  "\\subsubsection*{?}"
                  cdlatex-position-cursor nil t nil)))
    (push cmd cdlatex-command-alist))

  (setq cdlatex-env-alist
        '(("align" "\\begin{align}
?
\\end{align}" "\\\\AUTOLABEL
?")
          ("equation" "\\begin{equation}
?
\\end{equation}" nil)))

  (setq cdlatex-math-symbol-alist '((?F ("\\Phi"))
                                    (?o ("\\omega" "\\mho" "\\mathcal{O}"))
                                    (?. ("\\cdot" "\\circ"))
                                    (?6 ("\\partial"))
                                    (?v ("\\vee" "\\forall"))
                                    (?^ ("\\uparrow" "\\Updownarrow" "\\updownarrow"))))
  (setq cdlatex-math-modify-alist '((?k "\\mathfrak" "\\textfrak" t nil nil)
                                    (?b "\\mathbf" "\\textbf" t nil nil)
                                    (?B "\\mathbb" "\\textbf" t nil nil)
                                    (?t "\\text" nil t nil nil)))
  (setq cdlatex-paired-parens "$[{(")
  (cdlatex-reset-mode)
  )

(use-package lazytab
  :straight (:host github :repo  "karthink/lazytab" :branch "master" )
  :hook
  (LaTeX-mode . lazytab-mode)
  (LaTeX-math-mode . orgtbl-mode)
  :bind (:map orgtbl-mode-map
              ("<tab>" . lazytab-org-table-next-field-maybe)
              ("TAB" . lazytab-org-table-next-field-maybe))
  :after cdlatex
  :config
  (add-hook 'cdlatex-tab-hook #'lazytab-cdlatex-or-orgtbl-next-field 90)
  (dolist (cmd '(("smat" "Insert smallmatrix env"
                  "\\left( \\begin{smallmatrix} ? \\end{smallmatrix} \\right)"
                  lazytab-position-cursor-and-edit
                  nil nil t)
                 ("bmat" "Insert bmatrix env"
                  "\\begin{bmatrix} ? \\end{bmatrix}"
                  lazytab-position-cursor-and-edit
                  nil nil t)
                 ("pmat" "Insert pmatrix env"
                  "\\begin{pmatrix} ? \\end{pmatrix}"
                  lazytab-position-cursor-and-edit
                  nil nil t)
                 ("tbl" "Insert table"
                  "\\begin{table}\n\\centering ? \\caption{}\n\\end{table}\n"
                  lazytab-position-cursor-and-edit
                  nil t nil)))
    (push cmd cdlatex-command-alist))
  (cdlatex-reset-mode))

(use-package overleaf
  :straight t
  :custom
  (overleaf-use-nerdfont t "Use nerfont icons for the modeline.")
  :config
  ;; Example: load/save cookies from GPG encrypted file.
  ;;          (remove the .gpg extension to save unencrypted)
  (let ((cookie-file "~/.overleaf-cookies.gpg"))
    (setq overleaf-save-cookies
          (overleaf-save-cookies-to-file cookie-file))
    (setq overleaf-cookies
          (overleaf-read-cookies-from-file cookie-file))))

(use-package citar
  :straight t
  :hook
  (LaTeX-mode . citar-capf-setup)
  (org-mode . citar-capf-setup))

(use-package tex
  :straight auctex
  :config
  ;; (add-to-list 'TeX-command-list
  ;;              '("LaTeX (shell escape)"
  ;;                "%`%l%(mode)%' -shell-escape %T"
  ;;                TeX-run-TeX
  ;;                nil
  ;;                (latex-mode doctex-mode)
  ;;                :help "Run LaTeX with shell-escape enabled"))
  ;; (setq-default TeX-engine 'xetex)
  (setq TeX-engine-alist '((default
                            "Tectonic"
                            "tectonic -X compile -f plain %T"
                            "tectonic -X compile -f latex %T -Z search-path=/home/pfournier/Projets/TeX-packages/"
                            nil)))
  (setq LaTeX-command-style '(("" "%(latex)")))
  (setq TeX-process-asynchronous t
        TeX-check-TeX nil
        TeX-engine 'default)
  (let ((tex-list (assoc "TeX" TeX-command-list))
        (latex-list (assoc "LaTeX" TeX-command-list)))
    (setf (cadr tex-list) "%(tex)"
          (cadr latex-list) "%l"))
  (setq TeX-auto-save t)

  ;; Use Okular as pdf viewer.
  (delete '(output-pdf "Evince") TeX-view-program-selection)
  (add-to-list 'TeX-view-program-selection '(output-pdf "Okular")))


(provide 'jpdl/tex)
;;; tex.el ends here
