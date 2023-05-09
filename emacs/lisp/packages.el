;; Evil <3
(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  (setq evil-respect-visual-line-mode 1)
  (evil-mode 1)
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
  (hledger-mode . company-mode)
  :config
  (setq company-show-quick-access nil))
  (setq company-selection-wrap-around t)
  (setq company-idle-delay nil)


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


(use-package devdocs
  :ensure t)

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
  :hook ((text-mode prog-mode conf-mode snippet-mode) . yas-minor-mode-on)
  :init
  (setq yas-snippet-dir "~/.emacs.d/snippets")
  :config
  (setq yas-indent-line 'fixed))


(use-package speeddating
  :ensure t)


;; ORG CONFIG
(use-package org-bullets
  :ensure t
  :hook
  (org-mode . org-bullets-mode))


(use-package org
  :ensure t
  :mode
  ("\\.org\\'" . org-mode)
  :hook
  (org-capture-mode . evil-insert-state)  ;; start capture in insert mode
  (org-mode . set-accent-mode)  ;; start capture in insert mode
  :config
  ;; (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
  (setq org-directory (expand-file-name "~/.org"))
  (setq org-agenda-files (list org-directory))
  (setq org-hide-leading-stars t)
  (setq org-hide-emphasis-markers t)
  (setq org-adapt-indentation t)
  (setq org-ellipsis " …")
  (setq org-cycle-separator-lines 2)
  (setq org-todo-keywords
        (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
                (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))
  (setq org-use-fast-todo-selection t)
  (setq org-treat-S-cursor-todo-selection-as-state-change nil)
  ;; (setq org-tag-alist '(("@work" . ?w) ("@home" . ?h) ("laptop" . ?l)))
  (setq org-capture-templates
        '(("c" "inbox" entry (file "~/.org/inbox.org") "* TODO %?")
          ("n" "notes" entry (file "~/.org/inbox.org") "* %? :NOTE:\n%U\n%a\n")
          ("m" "meetings" entry (file "~/.org/inbox.org") "* TODO %^{Title} %t\n- %?"))))


;; use org-capture in fullscreen
(add-hook 'org-capture-mode-hook 'delete-other-windows)
