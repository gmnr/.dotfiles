;; REGEX

(defvar hledger-empty-regex "^[[:space:]]*$"
  "Regular expression for an empty line.")

(defvar hledger-date-regex "[0-9]\\{4\\}[-/][0-9]\\{2\\}[-/][0-9]\\{2\\}"
  "Regular expression for dates for font lock.")

(defvar hledger-amount-regex "-?[0-9]*\.?[0-9]+\\(,[0-9][0-9]\\)?\\( [A-Z]+\\)?"
  "Regular expression for amounts for font lock.")

(defvar hledger-neg-amount-regex "-[0-9]*\.?[0-9]+\\(,[0-9][0-9]\\)?\\( [A-Z]+\\)?"
  "Regular expression for negative amounts for font lock.")

(defvar hledger-payee-regex "-[0-9][0-9]\\s-\\(.*\\)\\s-|"
  "Regular expression for payees in font lock.")

(defvar hledger-account-regex
  (concat "\\(\\([Rr]evenues?\\|[aA]ssets?\\|[lL]iabilit\\(?:ies\\|y\\)\\|[Dd]ebts?"
	  "\\|[Ee]quity\\|[Ee]xpenses?\\|[iI]ncome\\|[Zz]adjustments?\\)"
	  "\\(:[A-Za-z0-9\-\.]+\\( [A-Za-z0-9\-\.]+\\)*\\)*\\)"))

(defvar hledger-sep-regex "\\(|\\|@@\\)"
  "Regular expression for payee/description separator in font lock.")


;; CONFIG DECLARATIONS

(defcustom hledger-reporting-buffer-name "*Personal Finance*"
  "Name of the buffer for showing or working with reports."
  :group 'hledger
  :type 'string)


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
  (hledger-prev-line-matchesp (concat ".*" hledger-amount-regex ".*")))


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

;; MODE SETUP

(defcustom hledger-mode-hook nil
  "Normal hook for entering 'hledger-mode'."
  :type 'hook
  :group 'hledger)

(defcustom hledger-date-face font-lock-string-face
  "Face for date."
  :type 'face
  :group 'hledger)

(defcustom hledger-amount-face font-lock-variable-name-face
  "Face for amount."
  :type 'face
  :group 'hledger)

(defcustom hledger-payee-face font-lock-builtin-face
  "Face for payee."
  :type 'face
  :group 'hledger)

(defcustom hledger-account-face font-lock-doc-markup-face
  "Face for accounts."
  :type 'face
  :group 'hledger)

(defcustom hledger-sep-face font-lock-keyword-face
  "Face for separator."
  :type 'face
  :group 'hledger)

(defcustom hledger-description-face nil
  "Face for description text."
  :type 'face
  :group 'hledger)

(defun hledger-font-lock-keywords-1 ()
  "Minimal highlighting expressions for hledger mode."
  (list
   `(,hledger-account-regex . hledger-account-face)
   `(,hledger-payee-regex 1 hledger-payee-face)
   `(,hledger-sep-regex . hledger-sep-face)
   `(,hledger-date-regex . hledger-date-face)
   `(,hledger-amount-regex . hledger-amount-face)))

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
  (setq-local require-final-newline t)
  (setq-local tab-width 2)
  (setq hledger-accounts-cache (hledger-get-accounts))
  (setq hledger-payee-cache (hledger-get-payees)))

;;;###autoload
(define-derived-mode hledger-mode fundamental-mode "HLedger" ()
  "Major mode for editing journal files."
  :syntax-table hledger-mode-syntax-table
  (hledger-mode-init))


;; add hook to run hledger in .journal files
(add-to-list 'auto-mode-alist '("\\.journal\\'" . hledger-mode))


