;; remove gui elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)


;; disable init message
(setq-default
 inhibit-startup-screen t
 inhibit-startup-message t
 inhibit-startup-echo-area-message t
 initial-scratch-message ""
 initial-buffer-choice t
 visible-bell nil)


;; disable tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)


;; don't show sign on fring for empty lines
(setq-default indicate-empty-lines nil)


;; always edit the symlink
(setq find-file-visit-truename 1)


;; enable line num & cursorlin
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
(global-auto-revert-mode t)


;; enable cmd as meta for mac
(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'none)


;; Use y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)


;; enable scrolling over long lines
(global-visual-line-mode 1)


