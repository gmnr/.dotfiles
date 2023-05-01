;; install one-dark theme
;; (use-package one-themes
;;   :ensure t
;;   :init
;;   (load-theme 'one-dark t))


(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)
  (doom-themes-org-config))


;; load custom font
(set-frame-font "DroidSansMono Nerd Font 16" nil t)


;; open emacs maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))


;; powerline
(use-package powerline
  :ensure t
  :config
  (powerline-center-theme)
  (setq powerline-arrow-shape 'curve))


