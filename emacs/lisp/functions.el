;; hledger mode wrapper
(defun temp-wrapper (report-name cmd)
  "Send shell commands to tmp-buffer"
  (interactive)
  (with-output-to-temp-buffer (concat"*" report-name "*")
    (shell-command cmd
                   (concat"*" report-name "*")
                   "*Messages*")
    (pop-to-buffer (concat"*" report-name "*")))
  (special-mode)
  (delete-other-windows))


(defun kill-all-buffers ()
  "Kill all buffers except current one and toolkit (*Messages*, *scratch*). Close other windows."
  (interactive)
  (mapcar 'kill-buffer (buffer-list))
  (delete-other-windows))


(require 'ansi-color)
(defun display-ansi-colors ()
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))
