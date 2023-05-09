(quail-define-package
 "accent-postfix" "UTF-8" "InR<" t
  "Input method for Indic transliteration with postfix modifiers.
  "
  nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
 ;; long vowels
 ("a''" "à")
 ("e\"\"" "é")
 ("e''" "è")
 ("i''" "ì")
 ("o''" "ò")
 ("u''" "ù")
)


(provide 'manage-accents)
