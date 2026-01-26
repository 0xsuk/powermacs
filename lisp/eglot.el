(use-package eglot
  :hook ((c++-mode c-mode)
         . eglot-ensure)
  :config
  ;; Disable Flymake to avoid conflicts with Flycheck
  (setq eglot-stay-out-of '(flymake))
  
  (setq eglot-ignored-server-capabilites
        '(:documentHighlightProvider ;;no highlight on hover
          :inlayHintProvider ;; no argument signatures
          )
        )
  
  
  (add-to-list 'eglot-server-programs
               `(python-mode
                 . ,(eglot-alternatives
                     '(("pyright-langserver" "--stdio")
                       "pylsp"))))
  (add-to-list 'eglot-server-programs
               '((c-mode c++-mode)
                 . ("clangd"
                    "-j=4"
                    "-background-index"
                    "--header-insertion=never"
                    "--header-insertion-decorators=0"
                    "-log=error"
                    "--enable-config")))
  
  (add-to-list 'eglot-server-programs
               '((typescript-ts-mode tsx-ts-mode js-ts-mode)
                 . ("typescript-language-server" "--stdio"
                    :initializationOptions
                    (:preferences
                     (:importModuleSpecifierPreference "non-relative")))))
  
  ;; https://joaotavora.github.io/eglot/
  ;; As usual with invoking programs, the executable file fools should be in one of the directories mentioned by the exec-path variable


  (fset #'jsonrpc--log-event #'ignore) ; idk. search "eglot sluggish"
  (setf (plist-get eglot-events-buffer-config :size) 0)
  
  
  ;; 
)


; makesure emacs-lsp-booster binary is avaiable under exec-path
; install using package-vc-install (see the readme)
(use-package eglot-booster
	:after eglot
	:config	(eglot-booster-mode))

;; Flycheck-Eglot integration: unify LSP diagnostics with Flycheck
(use-package flycheck-eglot
  :ensure nil
  :load-path "~/.emacs.d/lisp/MIT"
  :after (flycheck eglot)
  :config
  (global-flycheck-eglot-mode 1)
  (setq-default flycheck-eglot-exclusive nil) ; set nil if eglot-check wants to have next checker (like javascript-eslint)
  
  (flycheck-add-next-checker 'eglot-check 'javascript-eslint)
                                        ; at this point (2026/01), theres no official way  to configure checker w.r.t. major-modes. read https://github.com/flycheck/flycheck/issues/1762 for issue & workaround
  ; 
  )
