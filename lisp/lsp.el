(use-package lsp-mode
  :defer 1
  :commands (lsp lsp-deferred)
	:hook ((clojure-mode
					clojurec-mode
					c-mode
					c++-mode
					cmake-mode
					js-mode) . lsp-deferred)
	:custom
	(lsp-completion-provider :none) ; we use corfu
  :init
  (setq lsp-signature-auto-activate nil)
  (setq lsp-signature-render-documentation nil)
  ;; (setq lsp-eldoc-hook nil
				;; lsp-eldoc-enable-hover nil) ; do not display symbol info at the bottom
  (setq lsp-modeline-code-actions-enable nil)
  (setq lsp-modeline-diagnostics-enable nil)
  (setq lsp-headerline-breadcrumb-enable nil)
	(setq lsp-auto-configure t) ; for finer granularity manually configure lsp-enable-*
	;https://emacs-lsp.github.io/lsp-mode/page/settings/mode/#lsp-enable-folding
	;(setq lsp-enable-dap-auto-configure nil) ; dap = Debug Adapter Protocol
	;(setq lsp-enable-file-watchers nil) ; enable file watch if server requests
	;(setq lsp-enable-indentation nil) ; indent region (?)
	;(setq lsp-enable-links nil) ; ? something to do with references
  (setq lsp-enable-folding nil)
  (setq lsp-enable-imenu nil)
  ;(setq lsp-enable-snippet nil)
  (setq lsp-enable-on-type-formatting nil) ; do not format while typing (disable lsp protocol's textDocument/onTypeFormatting)
  (setq lsp-enable-symbol-highlighting nil)
	(setq lsp-enable-suggest-server-download t) ; do not suggest language server if not found
	(setq lsp-enable-text-document-color nil) ;?
	;(setq lsp-enable-xref nil) ; ?

  :config
  (lsp-enable-which-key-integration t)

	; clangd
	; install binary https://github.com/clangd/clangd/releases/download/16.0.2/clangd-linux-16.0.2.zip
	; !!important: old version causes "Marker does not point anywhere" error
	(setq lsp-clients-clangd-args '("-j=4" "-background-index" "--header-insertion=never" "--header-insertion-decorators=0" "-log=error")) ; https://github.com/emacs-lsp/lsp-mode/issues/2503
	;(setq lsp-clients-clangd-args '("--header-insertion-decorators=0")) ; with this and compile_commands.json, clangd will insert proper path but manual insertion is better
	;(delete 'company-clang company-backends) ; Experiment:=> DO NOT DO THIS. every feature is powered by company-clang
;
  )

(use-package lsp-ui
  :defer t
  ;:hook (lsp-mode . lsp-ui-mode) no need for this https://github.com/emacs-lsp/lsp-ui
  :config
  ;(lsp-ui-doc-show-with-cursor t)
  ;(lsp-ui-doc-enable t)
  (setq lsp-ui-imenu-enable t
				lsp-ui-sideline-show-diagnostics t
				lsp-ui-sideline-show-hover t
				lsp-ui-sideline-show-symbol nil ; annoying & u
				lsp-ui-doc-header t
				lsp-ui-doc-show-with-mouse nil ; does not display doc on mouse hover
				lsp-ui-sideline-enable nil ; stupid
				; lsp-ui-sideline-diagnostic-max-lines 100
				))
