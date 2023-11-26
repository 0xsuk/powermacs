(use-package eglot
  :hook ((c++-mode c-mode)
         . eglot-ensure)
  :config
  (setq eglot-ignored-server-capabilites
        '(:documentHighlightProvider ;;no highlight on hover
          :inlayHintProvider ;; no argument signatures
          )
        )
  
  ;; https://joaotavora.github.io/eglot/
  ;; As usual with invoking programs, the executable file fools should be in one of the directories mentioned by the exec-path variable
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
                 '((c-mode c++-mode)
                   . ("clangd"
                      "-j=4"
                      "-background-index"
                      "--header-insertion=never"
                      "--header-insertion-decorators=0"
                      "-log=error"
                      "--enable-config"))))
  )
