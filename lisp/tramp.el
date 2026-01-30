(use-package tramp
  :ensure nil

  :config

  ;; Enable TRAMP direct async processes for a given protocol/host profile.
  (connection-local-set-profile-variables
   'remote-direct-async-process
   '((tramp-direct-async-process . t)))

  ;; Example: enable for scp protocol (adjust to your setup).
  (connection-local-set-profiles
   '(:application tramp :protocol "scp")
   'remote-direct-async-process)

  ;; Magit tweak often needed when tramp-direct-async-process is enabled.
  ;; (setq magit-tramp-pipe-stty-settings 'pty)
  
  (setq remote-file-name-inhibit-locks t
      remote-file-name-inhibit-auto-save-visited t
      tramp-use-scp-direct-remote-copying t ; obsolete?
      )
  )
