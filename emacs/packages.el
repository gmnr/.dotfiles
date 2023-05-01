;; Evil <3
(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  :config
  (evil-set-undo-system 'undo-redo)
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-commentary
  :ensure t
  :config
  (evil-commentary-mode))


;; Magit
(use-package magit
  :ensure t
  :init
  (with-eval-after-load 'transient
    (transient-bind-q-to-quit)))


;; git-gutter package
(use-package diff-hl
  :ensure t
  :init
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  :config
  (global-diff-hl-mode)
  (diff-hl-flydiff-mode))


;; ivy
(use-package counsel
  :ensure t
  :diminish
  :config
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
  :init
  (add-hook 'after-init-hook 'global-company-mode))


;; Smart parens
(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode t))


;; rainbow delimiters
(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))


;; quickrun
(use-package quickrun
  :ensure t)


;; highlight indent line
(use-package highlight-indent-guides
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-responsive 'stack))


