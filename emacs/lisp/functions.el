(defun kill-all-buffers ()
  "Kill all buffers except current one and toolkit (*Messages*, *scratch*). Close other windows."
  (interactive)
  (mapcar 'kill-buffer (buffer-list))
  (delete-other-windows))


