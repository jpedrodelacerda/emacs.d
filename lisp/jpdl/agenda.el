(use-package org-agenda
  :straight t
  :after org
  :bind (("C-c c" . org-capture)
         ("C-c o" . org-agenda)
         ("C-c l" . org-agenda-list))
  :init
  (setq org-agenda-files (quote ("~/MEGAsync/agenda/pessoal.org"
                                 "~/MEGAsync/agenda/trabalho.org"
                                 "~/MEGAsync/agenda/ufrj.org"
                                 )))
  (setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))
  (setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "TRIP(t)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))
  (setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("MEETING" :foreground "forest green" :weight bold)
              ("TRIP" :foreground "blue" :weight bold)
              ("PHONE" :foreground "forest green" :weight bold))))

  (setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING") ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD") ("WISHLIST") ("TRIP"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD") ("WISHLIST"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD") ("BOUGHT")))))

  (setq org-capture-templates
      (quote (("t" "todo" entry (file "~/MEGAsync/agenda/refile.org")
               "* TODO %?\n%U\n")
              ("a" "respond" entry (file "~/MEGAsync/agenda/refile.org")
               "* NEXT Responder %:from sobre %:subject\nSCHEDULED: %t\n%U\n%a\n" :immediate-finish t)
              ("n" "note" entry (file "~/MEGAsync/agenda/refile.org")
               "* %? :NOTE:\n%U\n%a\n")
              ("v" "trip" entry (file "~/MEGAsync/agenda/refile.org")
               "* TRIP %? \n  SCHEDULED: \n%U\n")
              ("j" "Journal" entry (file+datetree "~/MEGAsync/agenda/journal.org")
               "* %?\n%U\n")
              ("r" "org-protocol" entry (file "~/MEGAsync/agenda/refile.org")
               "* TODO Revisar %c\n%U\n" :immediate-finish t)
              ("m" "Reunião" entry (file "~/MEGAsync/agenda/refile.org")
               "* MEETING %? :MEETING:\n%U")
              ("p" "Ligação" entry (file "~/MEGAsync/agenda/refile.org")
               "* PHONE %? :PHONE:\n%U")
              ("h" "Habit" entry (file "~/MEGAsync/agenda/refile.org")
               "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))
  )

(provide 'jpdl/agenda)
