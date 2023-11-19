(use-package consult
	:config
	(consult-customize consult-recent-file consult-buffer consult-ripgrep :preview-key "C-l")
	)


;;TODO sort dirs by length
(use-package consult-dir
	:config
  (defvar my-dirs
    '(:name "My Dirs"
            :category file
            :face consult-file
            :items ("~/.emacs.d/"
                    "~/code/"
                    "~/inst/"
                    "~/downloads/"
                    "~/quicklisp/local-projects/"
                    "~/documents/")
            ))
  
  (add-to-list 'consult-dir-sources 'my-dirs)
  
  (defun consult-dir--fasd-dirs ()
	  (mapcar (lambda (str) (concat str "/")) (split-string (shell-command-to-string "fasd -ld") "\n" t)))

  (defvar consult-dir--source-fasd
    `(:name "Fasd dirs"
            :narrow   ?f
            :category file
            :face     consult-file
            :history  file-name-history
            :enabled  ,(lambda () (executable-find "fasd"))
            :items    ,#'consult-dir--fasd-dirs)
    "Fasd directory source for `consult-dir'.")

  (add-to-list 'consult-dir-sources 'consult-dir--source-fasd t)
	)
