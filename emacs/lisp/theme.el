(use-package doom-themes
  :ensure t
  :init
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t)
  (load-theme 'doom-one t)
  (doom-themes-org-config))


;; load custom font
(set-frame-font "DroidSansMono Nerd Font 16" nil t)


;; open emacs maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))


;; powerline
(use-package doom-modeline
  :ensure t
  :init
  (doom-modeline-mode 1)
  :config
  (setq doom-modeline-modal-icon nil))



