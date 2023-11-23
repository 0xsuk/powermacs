(use-package consult
	:config
	(consult-customize consult-recent-file consult-buffer consult-ripgrep :preview-key "C-l")
	)

(use-package consult-lsp
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
  
  (defun get-buffers-major-mode (&optional major-mode-symbol)
    "Return a list of buffers with the specified major mode."
    (unless major-mode-symbol
      (setq major-mode-symbol major-mode))
    (cl-remove-if-not
     (lambda (buf)
       (with-current-buffer buf
         (eq major-mode major-mode-symbol)))
     (mapcar 'buffer-name (buffer-list))))
  
  (defvar consult--major-mode-buffers
    `(:name "Major mode buffers"
            :category buffer
            :face consult-buffer
            :items  ,#'get-buffers-major-mode
            :action ,#'consult--buffer-action))
  
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
