(defun gmnr/kill-all-buffers ()
  "Kill all buffers except current one and toolkit (*Messages*, *scratch*). Close other windows."
  (interactive)
  (mapcar 'kill-buffer (buffer-list))
  (delete-other-windows))


(defun gmnr/set-accent-mode ()
  "Create hook to enable accented input mode"
  (activate-input-method "accent-postfix"))

(defun gmnr/save-and-quit ()
  "save current buffer and quit it"
  (interactive)
  (save-buffer)
  (kill-buffer))

