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
    "lb" (lambda () (interactive) (temp-wrapper "hledger Report" "hledger -f ~/.finance/all.journal bs --pretty -V --drop 1 -t"))
    "li" (lambda () (interactive) (temp-wrapper "hledger Report" "hledger -f ~/.finance/all.journal is --pretty -l --drop 1 -p thismonth"))
    ;; "ll" (lambda () (interactive) (temp-wrapper "hledger Report" "hledger -f ~/.finance/all.journal is --pretty -l --drop 1 -p thismonth"))
    "lp" (lambda () (interactive) (temp-wrapper "Latest Quotes" "python3 ~/.finance/.src/fetch.py solo"))
    "ld" (lambda () (interactive) (temp-wrapper "Latest Quotes" "python3 ~/.finance/.src/fetch.py full"))


    ;; manage files
    "es" (lambda () (interactive) (load user-init-file))
    "ev" (lambda () (interactive (counsel-find-file "~/.emacs.d/user-config/")))
    "ep" (lambda () (interactive (find-file "~/.emacs.d/user-config/packages.el")))
    "ee" (lambda () (interactive) (find-file "~/.finance/periods/2023.journal") (end-of-buffer))
    "eb" 'eval-buffer

    ;; defaults
    "qq" 'evil-delete-buffer
    "ww" 'save-buffer
    "wq" 'evil-save-and-close
    "QA" 'kill-all-buffers

    ;; magit
    "gs" 'magit-status
    "hp" 'diff-hl-show-hunk
    "hr" 'diff-hl-revert-hunk

    ;; navigation
    "po" 'ivy-switch-buffer
    "pi" 'projectile-switch-project
    "pl" 'counsel-rg
    "pp" 'counsel-git

    ;; M-X
    "SPC" 'counsel-M-x)

  (general-define-key
    :states '(normal visual)
    "C-e" 'evil-scroll-up
    "DEL" 'evil-switch-to-windows-last-buffer
    "]c" 'diff-hl-next-hunk
    "[c" 'diff-hl-previous-hunk))
