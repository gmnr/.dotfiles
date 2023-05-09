;; REGEX

(defvar hledger-empty-regex "^[[:space:]]*$"
  "Regular expression for an empty line.")

(defvar hledger-date-regex "[0-9]\\{4\\}[-/][0-9]\\{2\\}\\([-/][0-9]\\{2\\}\\)?"
  "Regular expression for dates for font lock.")

(defvar hledger-payee-regex "-[0-9][0-9]\\s-\\(.*\\)\\s-|"
  "Regular expression for payees in font lock.")

(defvar hledger-account-regex
  (concat "^  \\(\\(revenues?\\|assets?\\|liabilit\\(?:ies\\|y\\)\\|debts?"
	  "\\|equity\\|expenses?\\|income\\|adjustments?\\)"
	  "\\(:[A-Za-z0-9\-\.]+\\( [A-Za-z0-9\-\.]+\\)*\\)*\\)"))

(defvar hledger-highlight-amount-regex (concat "\\(" hledger-account-regex "\s+"
                                           "\\)" "\\(-?[0-9]+,[0-9][0-9]\\)"))

(defvar hledger-sep-regex "\\(|\\|@@\\)"
  "Regular expression for payee/description separator in font lock.")


;; VIEW MODE REGEX

(defvar hledger-view-null-regex "\s0\s"
  "Regular expression for ignore in font lock.")

(defvar hledger-view-neg-regex "-[0-9]*\.?[0-9]+,[0-9][0-9] [A-Z]+"
  "Regular expression for negative amounts for font lock.")

(defvar hledger-view-amount-regex " [0-9]*\.?[0-9]+\\(,[0-9][0-9]\\)? [A-Z]+"
  "Regular expression for negative amounts for font lock.")

(defvar hledger-view-titles-regex "\\(Revenues\\|Expenses\\|Net:\\|Assets\\|Liabilities\\)"
  "Regular expression for negative amounts for font lock.")

(defvar hledger-view-months-regex "\\(Total\\|Average\\|Jan\\|Feb\\|Mar\\|Apr\\|May\\|Jun\\|Jul\\|Aug\\|Sep\\|Oct\\|Nov\\|Dec\\)"
  "Regular expression for negative amounts for font lock.")

(defvar hledger-view-account-regex "\\(\s+[a-z\:A-Z\-\.]+\s+\\)║"
  "Regular expression for negative amounts for font lock.")

(defvar hledger-view-account-bal-regex "[A-Z]+  \\([a-z\:A-Z\-\.]+\\)"
  "Regular expression for negative amounts for font lock.")


;; INDENTATION RULES

(defun hledger-line-matchesp (re offset)
  "Check if regex RE will match the beginning for line current-line - OFFSET."
  (save-excursion
    (forward-line offset)
    (beginning-of-line)
    (looking-at re)))

(defun hledger-cur-line-matchesp (re)
  "Return true if current line has regex RE in the beginning."
  (hledger-line-matchesp re 0))

(defun hledger-prev-line-matchesp (re)
  "Return true if previous line has regex RE in the beginning."
  (hledger-line-matchesp re -1))


(defun hledger-cur-line-emptyp ()
  "Return true if current line is empty."
  (hledger-cur-line-matchesp hledger-empty-regex))

(defun hledger-prev-line-emptyp ()
  "Return true if previous line is empty."
  (hledger-prev-line-matchesp hledger-empty-regex))

(defun hledger-prev-line-has-payeep ()
  "Return true if current line is a transaction definition."
  (hledger-prev-line-matchesp (concat ".*" hledger-payee-regex ".*")))

(defun hledger-prev-line-has-amtp ()
  "Return true if the current line has an amount."
  (hledger-prev-line-matchesp (concat ".*" hledger-highlight-amount-regex ".*")))

(defun hledger-indent-empty-line ()
  "Called when the line to be indented is an empty one."
  (cond
   ((hledger-prev-line-emptyp) (hledger-insert-date) (hledger-select-payee))
   ((hledger-prev-line-has-payeep) (indent-line-to tab-width) (hledger-select-account) (hledger-get-amount))
   ((hledger-prev-line-has-amtp) (indent-line-to tab-width) (hledger-select-account) (newline-and-indent))
   (t (indent-line-to tab-width))))

(defun hledger-indent-line ()
  "Indent the current line."
  (cond
   ((hledger-cur-line-emptyp) (hledger-indent-empty-line))))


;; FUNCTIONS

(defun hledger-insert-date ()
  "Insert date at point."
  (insert (format-time-string "%Y-%m-%d ")))

(defun hledger-get-payees ()
  (split-string (shell-command-to-string "hledger -f ~/.finance/all.journal payees") "\n"))

(defun hledger-get-accounts ()
  (split-string (shell-command-to-string "hledger -f ~/.finance/all.journal accounts")))

(defun hledger-select-payee ()
  "Fetch from cache the list of payees for fuzzy insertion"
  (interactive)
  (ivy-read "Select Payee: "
            hledger-payee-cache
            :action (lambda (x) (insert x " | "))))

(defun hledger-select-account ()
  "Fetch from cache the list of accounts for fuzzy insertion"
  (interactive)
  (ivy-read "Select Payee: "
            hledger-accounts-cache
            :action (lambda (x) (insert x "  "))))

(defun hledger-get-amount ()
  "Get user input and perform simple calculations"
  (insert (replace-regexp-in-string "\\." "," (calc-eval (replace-regexp-in-string "," "\." (read-string "Insert Amount ->> ")))))
  (hledger-format-transaction)
  (newline-and-indent))

(defun hledger-format-transaction ()
  "Format transaction to correctly display amount and format"
  (interactive)
  (setq val (split-string (buffer-substring-no-properties (line-beginning-position) (line-end-position)) "\s+" t))
  (delete-region (line-beginning-position) (line-end-position))
  (setq acc (pop val))
  (setq amt (hledger-format-amount (pop val)))
  (setq l-acc (length acc))
  (setq l-amt (length amt))
  (setq spaces (- 60 l-amt l-acc))
  (insert (concat "  " acc))
  (dotimes (_ spaces) (insert " "))
  (insert amt))

(defun hledger-format-amount (amt)
  "Format the amount of the transaction to the following specification '1.000,00'"
  (setq sides (split-string amt ","))
  (setq int (pop sides))
  (setq dec (pop sides))
  (if (> (length int) 3)
      (setq int (hledger-thousands int))
    int)
  (if (eq dec nil)
      (setq dec "00")
    (if (eq (length dec) 1)
        (setq dec (concat dec "0"))
      dec))
  (concat int "," dec))

(defun hledger-thousands (s &optional separator)
  "Add commas to NUMBER and return it as a string. Optional SEPARATOR is the string to use to separate groups. It defaults to a dot."
  (let ((num s)
        (op (or separator ".")))
    (while (string-match "\\(.*[0-9]\\)\\([0-9][0-9][0-9].*\\)" num)
      (setq num (concat 
                 (match-string 1 num) op
                 (match-string 2 num))))
    num))


;; REPORT

(defun hledger-wrapper (report-name cmd)
  "Wrap command execution in hledger mode"
  (with-output-to-temp-buffer (concat"*" report-name "*")
    (shell-command cmd
                   (concat"*" report-name "*")
                   "*Messages*")
    (pop-to-buffer (concat"*" report-name "*")))
  (delete-other-windows)
  (hledger-mode)
  (use-local-map (copy-keymap special-mode-map))
  (local-set-key "q" 'quit-window))

(defun hledger-execute-report (cmd)
  "Execute report with specific rules for formatting"
  (setq base "hledger -f ~/.finance/all.journal ")
  (setq w (- (window-total-width) 6))
  (setq else "")

  (cond
   ((string-equal cmd "is") (setq postfix " --drop 1 -p thismonth --pretty -S"))
   ((string-equal cmd "bs") (setq postfix " --drop 1 -V -t --pretty"))


   ((string-equal cmd "cust") (setq user-input (split-string (read-string "hledger expression>> ") "\s"))
                             (setq cmd (car user-input))
                             (setq else (string-join (cdr user-input) " "))
                             (if (or (string-equal cmd "reg") (string-equal cmd "areg"))
                               (setq postfix (concat " --pretty -p thismonth -w" (number-to-string w)))
                               (setq postfix " --pretty --drop 1"))))

  (hledger-wrapper "hledger report" (concat base cmd postfix " " else)))


;; HLEDGER MODE

(defcustom hledger-mode-hook nil
  "Normal hook for entering 'hledger-mode'."
  :type 'hook
  :group 'hledger)

(defcustom hledger-green-face font-lock-string-face
  "Green"
  :type 'face
  :group 'hledger)

(defcustom hledger-orange-face font-lock-variable-name-face
  "Orange"
  :type 'face
  :group 'hledger)

(defcustom hledger-blue-face font-lock-builtin-face
  "Blue"
  :type 'face
  :group 'hledger)

(defcustom hledger-red-face font-lock-doc-markup-face
  "Red"
  :type 'face
  :group 'hledger)

(defcustom hledger-cyan-face font-lock-keyword-face
  "Cyan"
  :type 'face
  :group 'hledger)

(defcustom hledger-purple-face font-lock-type-face
  "Purple"
  :type 'face
  :group 'hledger)

(defcustom hledger-white-face nil
  "White"
  :type 'face
  :group 'hledger)

(defcustom hledger-grey-face font-lock-comment-face
  "Grey"
  :type 'face
  :group 'hledger)

(defun hledger-font-lock-keywords-1 ()
  "Minimal highlighting expressions for hledger mode."
  (list
   `(,hledger-account-regex . hledger-red-face)
   `(,hledger-payee-regex 1 hledger-blue-face)
   `(,hledger-sep-regex . hledger-cyan-face)
   `(,hledger-date-regex . hledger-green-face)
   `(,hledger-highlight-amount-regex 6 hledger-orange-face)

   `(,hledger-view-null-regex . hledger-grey-face)
   `(,hledger-view-neg-regex . hledger-red-face)
   `(,hledger-view-months-regex . hledger-green-face)
   `(,hledger-view-titles-regex . hledger-purple-face)
   `(,hledger-view-amount-regex . hledger-blue-face)
   `(,hledger-view-account-bal-regex 1 hledger-orange-face)
   `(,hledger-view-account-regex 1 hledger-orange-face)))

(defun hledger-font-lock-defaults ()
  "Default highlighting expressions for hledger mode."
  (list (hledger-font-lock-keywords-1)))

(defvar hledger-mode-syntax-table (let ((st (make-syntax-table)))
                                    (modify-syntax-entry ?: "_" st)
                                    (modify-syntax-entry ?\; "<" st)
                                    (modify-syntax-entry ?\n ">" st)
                                    st)
  "Syntax table for hledger mode.")

(defun hledger-mode-init ()
  "Function that does initial setup in the \"major-mode\" function."
  (setq font-lock-defaults (hledger-font-lock-defaults))
  (setq-local indent-line-function 'hledger-indent-line)
  (setq-local comment-start "; ")
  (setq-local comment-end "")
  (setq-local tab-width 2)
  (set-accent-mode)
  (setq hledger-accounts-cache (hledger-get-accounts))
  (setq hledger-payee-cache (hledger-get-payees)))

;;;###autoload
(define-derived-mode hledger-mode fundamental-mode "HLedger" ()
  "Major mode for editing journal files."
  :syntax-table hledger-mode-syntax-table
  (hledger-mode-init))


;; add hook to run hledger in .journal files
(add-to-list 'auto-mode-alist '("\\.journal\\'" . hledger-mode))


