(use-package opencode
  :ensure nil


  :config

  (defun my-is-magit-derived-p (mode)
    (provided-mode-derived-p mode #'magit-mode)
    )
  
  (defun my-get-magit-file-path-at-cursor ()
    (magit-diff--file))
  
  (defun my-copy-file-reference ()
    (interactive)
    (let* ((magit-p (my-is-magit-derived-p major-mode))
           (file-path (if magit-p (my-get-magit-file-path-at-cursor)
                        (buffer-file-name))))
      (if file-path
          (progn
            (kill-new (format "@%s" file-path))
            (message "copied: %s" file-path))
        (message "not a file")
        )
      )
    )
  )
