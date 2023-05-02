;; Evil <3
(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  (evil-mode 1)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-set-undo-system 'undo-redo)
  (setq evil-insert-state-message nil) ;; disable showing current state on echo area
  (setq evil-visual-state-message nil) ;; disable showing current state on echo area
  (setq evil-want-Y-yank-to-eol t)) ;; Y behaves like y$


(use-package evil-collection
  :after evil
  :ensure t
  :init
  (evil-collection-init))


(use-package evil-commentary
  :ensure t
  :init
  (evil-commentary-mode))


;; Magit
(use-package magit
  :ensure t
  :init
  (with-eval-after-load 'transient
    (transient-bind-q-to-quit)))


;; git-gutter
(use-package git-gutter-fringe
  :ensure t
  :init
  (global-git-gutter-mode 1)
  :config
  (defconst doom-fringe-size '3 "Default fringe width")
  (setq-default fringes-outside-margins t)
  (fringe-mode doom-fringe-size)
  (push `(left-fringe  . ,doom-fringe-size) default-frame-alist)
  (push `(right-fringe . ,doom-fringe-size) default-frame-alist)
  (define-fringe-bitmap 'git-gutter-fr:added [224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224] nil nil 'center)
  (define-fringe-bitmap 'git-gutter-fr:modified [224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224] nil nil 'center)
  (define-fringe-bitmap 'git-gutter-fr:deleted [0 0 0 0 0 0 0 0 0 0 0 0 0 128 192 224 240 248] nil nil 'center))


;; ivy
(use-package counsel
  :ensure t
  :diminish
  :init
  (use-package flx
    :ensure t)
  (ivy-mode 1)
  (setq ivy-extra-directories nil)
  (setq ivy-re-builders-alist '((t . ivy--regex-fuzzy))))


;; Projectile
(use-package projectile
  :ensure t
  :init
  (projectile-mode 1)
  :config
  (setq projectile-enable-caching t))


;; Company (autocompletion)
(use-package company
  :ensure t
  :hook
  (prog-mode . company-mode)
  (text-mode . company-mode)
  :config
  (setq company-show-quick-access nil))
  ;; (setq company-idle-delay 0.1)
  ;; (setq company-minimum-prefix-length 2))


;; Company box
(use-package company-box
  :ensure t
  :hook
  (company-mode . company-box-mode)
  :config
  (setq company-box-backends-colors nil))


;; Smart parens
(use-package smartparens
  :ensure t
  :init
  (smartparens-global-mode t)
  :config
  (sp-local-pair '(emacs-lisp-mode) "'" "'" :actions nil))


;; rainbow delimiters
(use-package rainbow-delimiters
  :ensure t
  :hook  (prog-mode . rainbow-delimiters-mode))


;; quickrun
(use-package quickrun
  :ensure t)


;; highlight indent line
(use-package highlight-indent-guides
  :ensure t
  :hook
  (prog-mode . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character))


;; enable snippets
(use-package yasnippet
  :ensure t
  :hook
  (prog-mode . yas-minor-mode)
  (text-mode . yas-minor-mode)
  :config
  (setq yas-indent-line 'fixed))


;; glorious org-mode
(use-package org
  :ensure t
  :hook
  (org-capture-mode . evil-insert-state)  ;; start capture in insert mode
  :config
  (setq org-directory (expand-file-name "~/.org"))
  (setq org-hide-leading-stars t)
  (setq org-ellipsis " ▼ ")
  (setq-default org-display-custom-times t)
  (setq org-time-stamp-custom-formats '("<%a %d %b %Y>" . "<%a %d %b %Y %H:%M>"))
  (setq org-capture-templates
        '(("n" "Notes" entry
           (file "~/.org/inbox.org") "* %^{Description} %^g\n Added: %U\n%?")
          ("m" "Meeting notes" entry
           (file "~/.org/meetings.org") "* TODO %^{Title} %t\n- %?")
          ("t" "TODO" entry
           (file "~/.org/inbox.org") "* TODO %^{Title}")
          ("e" "Event" entry
           (file "~/.org/calendar.org") "* %^{Is it a todo?||TODO |NEXT }%^{Title}\n%^t\n%?")
          ("w" "Work TODO" entry
           (file "~/.org/work.org") "* TODO %^{Title}"))))

