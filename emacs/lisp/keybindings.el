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
    "li" (lambda () (interactive) (hledger-execute-report "is"))
    "lo" (lambda () (interactive) (hledger-execute-report "bs"))
    "ll" (lambda () (interactive) (hledger-execute-report "cust"))
    "lf" 'hledger-format-transaction
    ;; "lp" (lambda () (interactive) (temp-wrapper "Latest Quotes" "python3 ~/.finance/.src/fetch.py solo"))
    ;; "ld" (lambda () (interactive) (temp-wrapper "Latest Quotes" "python3 ~/.finance/.src/fetch.py full"))


    ;; navigate files
    "ev" (lambda () (interactive) (counsel-find-file nil "~/.emacs.d/lisp/"))
    "el" (lambda () (interactive) (find-file "~/.finance/periods/2023.journal") (end-of-buffer) (previous-line))
    "ei" (lambda () (interactive) (find-file "~/.org/inbox.org"))
    "oo" (lambda () (interactive) (counsel-find-file nil "~/.org/"))


    ;; load files and eval
    "ts" (lambda () (interactive) (load user-init-file))
    "tb" 'eval-buffer
    "tt" 'shell-command

    ;; defaults
    "qq" 'evil-delete-buffer
    "ww" 'save-buffer
    "wq" 'gmnr/save-and-quit
    "Qa" 'gmnr/kill-all-buffers

    ;; magit
    "gs" 'magit-status
    "hp" 'git-gutter:popup-hunk
    "hr" 'git-gutter:revert-hunk

    ;; org-mode
    "oa" 'org-agenda
    "oc" 'org-capture
    "ol" 'org-store-link
    "or" 'org-refile
    "oR" 'org-archive-subtree
    "Oo" 'org-switchb

    ;; org commands
    "ot" 'org-set-tags-command
    "ow" 'org-todo
    "os" 'org-schedule
    "od" 'org-deadline
    "og" 'org-toggle-heading
    "ox" 'org-cut-subtree
    "oy" 'org-paste-subtree

    ;; navigation
    "po" 'ivy-switch-buffer
    "pi" 'projectile-switch-project
    "pl" 'counsel-rg
    "pp" 'counsel-git
    "pf" 'find-file

    ;; help
    "hx" 'eval-defun
    "hf" 'describe-function
    "hv" 'describe-variable
    "hk" 'describe-key
    "ho" 'describe-symbol
    "hb" 'describe-command
    "hd" 'devdocs-lookup

    ;; smartparens
    "s<" 'sp-backward-barf-sexp
    "s>" 'sp-forward-barf-sexp
    "s(" 'sp-backward-slurp-sexp
    "s)" 'sp-forward-slurp-sexp
    "sd" 'sp-unwrap-sexp
    "s+" 'sp-join-sexp
    "s-" 'sp-split-sexp
    "sa" 'sp-absorb-sexp
    "sc" 'sp-clone-sexp
    "sC" 'sp-convolute-sexp
    "sm" 'sp-mark-sexp
    "sr" 'sp-raise-sexp
    "ss" 'sp-splice-sexp-killing-around
    "st" 'sp-transpose-sexp
    "sT" 'sp-transpose-hybrid-sexp

    ;; M-X
    "SPC" 'counsel-M-x)

  ;; global effective keybindings in normal & visual mode
  (general-define-key
    :states '(normal visual)
    "C-e" 'evil-scroll-up
    "C-u" 'evil-scroll-up
    "DEL" 'evil-switch-to-windows-last-buffer
    "]c" 'git-gutter:next-hunk
    "[c" 'git-gutter:previous-hunk
    "C-=" 'speeddating-increase
    "C--" 'speeddating-decrease
    "C-l" (lambda () (interactive) (redraw-frame nil)))

  ;; global effective keybindings in insert mode
  (general-define-key
    :states '(insert)
    "C-n" 'company-complete
    "C-p" 'company-complete
    "C-e" (lambda () (interactive) (insert "€")))

  ;; org bindings
  (general-define-key
   :keymaps 'org-capture-mode-map
   [remap evil-save-and-close]          'org-capture-finalize
   [remap evil-save-modified-and-close] 'org-capture-finalize
   [remap evil-quit]                    'org-capture-kill)

  (general-define-key
   :keymaps 'org-agenda-mode-map
   "j" 'org-agenda-next-line
   "k" 'org-agenda-previous-line
   "f" 'org-agenda-goto-date
   "n" 'org-agenda-later
   "p" 'org-agenda-earlier)

  ;; minibuffer settings
  (general-define-key
   :keymaps '(ivy-minibuffer-map minibuffer-local-map)
   "C-w" 'backward-kill-word))


;; use esc to quit everything
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


