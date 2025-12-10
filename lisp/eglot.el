(use-package eglot
  :hook ((c++-mode c-mode)
         . eglot-ensure)
  :config
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
