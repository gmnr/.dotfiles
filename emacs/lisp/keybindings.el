(use-package general
  :ensure t
  :config
  (general-define-key
    :states '(normal visual)
    :keymaps 'override
    :prefix "SPC"

    ;; window management
    "ah" 'evil-window-left
    "aj" 'evil-window-down
    "ak" 'evil-window-up
    "al" 'evil-window-right
    "ac" 'evil-window-delete
    "an" 'evil-window-new
    "as" 'evil-window-split
    "av" 'evil-window-vsplit
    "ao" 'delete-other-windows
    "aw" 'evil-window-next

    ;; quickrun
    "rr" 'quickrun

    ;; hledger
    "lo" (lambda () (interactive) (temp-wrapper "hledger Report" "hledger -f ~/.finance/all.journal bs --pretty -V --drop 1 -t"))
    "li" (lambda () (interactive) (temp-wrapper "hledger Report" "hledger -f ~/.finance/all.journal is --pretty -l --drop 1 -p thismonth"))
    "lp" (lambda () (interactive) (temp-wrapper "hledger Custom Report" (concat "hledger -f ~/.finance/all.journal " (read-string "hledger expr. >> ") " --pretty")))
    "ll" (lambda () (interactive) (find-file "~/.finance/periods/2023.journal") (end-of-buffer))
    ;; "lp" (lambda () (interactive) (temp-wrapper "Latest Quotes" "python3 ~/.finance/.src/fetch.py solo"))
    ;; "ld" (lambda () (interactive) (temp-wrapper "Latest Quotes" "python3 ~/.finance/.src/fetch.py full"))


    ;; manage files
    "es" (lambda () (interactive) (load user-init-file))
    "ev" (lambda () (interactive (counsel-find-file "~/.emacs.d/lisp/")))
    "ep" (lambda () (interactive (find-file "~/.emacs.d/lisp/packages.el")))
    "eb" 'eval-buffer
    "et" 'shell-command

    ;; defaults
    "qq" 'evil-delete-buffer
    "ww" 'save-buffer
    "wq" 'evil-save-and-close
    "Qa" 'kill-all-buffers

    ;; magit
    "gs" 'magit-status
    "hp" 'git-gutter:popup-hunk
    "hr" 'git-gutter:revert-hunk

    ;; org-mode
    "oa" 'org-agenda
    "oc" 'org-capture
    "ol" 'org-store-link
    "or" 'org-refile
    "oo" 'org-switchb

    ;; navigation
    "po" 'ivy-switch-buffer
    "pi" 'projectile-switch-project
    "pl" 'counsel-rg
    "pp" 'counsel-git
    "pf" 'find-file

    ;; M-X
    "SPC" 'counsel-M-x)

  ;; global effective keybindings
  (general-define-key
    :states '(normal visual)
    "C-e" 'evil-scroll-up
    "DEL" 'evil-switch-to-windows-last-buffer
    "]c" 'git-gutter:next-hunk
    "[c" 'git-gutter:previous-hunk
    "C-l" (lambda () (interactive) (redraw-frame nil)))
  
  ;; enable manual completion with ctrl-n and ctrl-p
  (general-define-key
    :states '(insert)
    "C-n" 'company-complete
    "C-p" 'company-complete)

  ;; minibuffer settings
  (general-define-key
   :keymaps '(ivy-minibuffer-map minibuffer-local-map)
   "C-w" 'backward-kill-word))


;; use esc to quit everything
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


