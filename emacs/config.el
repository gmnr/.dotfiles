;; remove gui elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)


;; disable init message
(setq inhibit-startup-message t
      visible-bell nil)


;; disable tabs
(setq-default indent-tabs-mode nil)


;; always edit the symlink
(setq find-file-visit-truename 1)


;; enable line num & cursorline
(global-display-line-numbers-mode 1)
(global-hl-line-mode 1)


;; delete old version
(setq delete-old-versions -1)


;; enable version control
(setq version-control t)


;; silent bell
(setq ring-bell-function 'ignore)


;; wrap text at the 80th char
(setq default-fill-column 80)


;; automatically reload files if they have been changed outside emacs
(global-auto-revert-mode 1)
