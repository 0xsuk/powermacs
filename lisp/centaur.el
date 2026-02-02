(use-package centaur-tabs
  :quelpa (centaur-tabs :fetcher github :repo "ema2159/centaur-tabs" :commit "5ad22d9a6a5d056a07f08b6fe6253f2a71f94ad8")
  :custom
  (centaur-tabs-hide-tabs-hooks
   ;; '(magit-status-mode-hook
     ;; magit-popup-mode-hook
     ;; reb-mode-hook
     ;; completion-list-mode-hook)
   nil
   )
  
  :config
  (centaur-tabs-mode t)
  (setq centaur-tabs-style "bar")
  (setq centaur-tabs-set-bar 'over)
  (setq centaur-tabs-set-close-button nil)
  (setq centaur-tabs-cycle-scope 'tabs)
  (setq centaur-tabs-adjust-buffer-order t)
  (centaur-tabs-enable-buffer-reordering)
  ;; (centaur-tabs-group-by-projectile-project)
  
  
  (defun my-centaur-tabs-hide-tab (x)
    "Do no to show buffer X in tabs."
    (let ((name (format "%s" x)))
      (or
       ;; Current window is not dedicated window.
       ;; (window-dedicated-p (selected-window))

       ;; Buffer name not match below blacklist.
       (cl-dolist (prefix centaur-tabs-excluded-prefixes)
         (when (string-prefix-p prefix name)
           (cl-return t)))

       ; Is not magit buffer
       ;; (and (string-prefix-p "magit" name)
       ;;      (not (file-name-extension name)))
       )))
  
  (setq centaur-tabs-hide-tab-function 'my-centaur-tabs-hide-tab) ; to use with popper
  
  
  (defun centaur-tabs-buffer-groups ()
    (list
     (cond
      ((eq major-mode 'magit-status-mode) "magit-status")
      ((memq major-mode '(magit-process-mode
                          magit-diff-mode
                          magit-log-mode
                          magit-file-mode
                          magit-blob-mode
                          magit-blame-mode
                          ))
       "magit")
      ((derived-mode-p 'prog-mode)
       "prog")
      ((derived-mode-p 'dired-mode)
       "dired")
      ((derived-mode-p 'vterm-mode)
       "vterm")
      ((memq major-mode '(helpful-mode
                          help-mode))
       "help")
      (t
       "other"
       ;; (centaur-tabs-get-group-name (current-buffer))
       )
      )))

  
  )



