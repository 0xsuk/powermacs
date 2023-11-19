(use-package company
  :hook (prog-mode eshell-mode sly-mrepl-mode)
  :bind
  (:map company-active-map
				("<tab>" . company-complete-selection)
				("<C-tab>" . company-complete-common)
				("C-l" . company-abort)
				("C-j" . company-select-next-or-abort)
				("C-k" . company-select-previous-or-abort)
				("<return>" . nil)
				("C-n" . nil)
				("C-p" . nil)
				("C-h" . nil)
				("C-w" . nil)
				("RET" . nil)) ; map RET to current major mode's ret
  :config
  (setq company-minimum-prefix-length 1
				company-idle-delay 0.01) ; 0 is no good
  ;(add-hook 'lsp-mode-hook ; do not use :bind. lsp-mode-map is not defined until lsp-mode is activated
	;    #'(my-l (define-key lsp-mode-map (kbd "<tab>") 'company-indent-or-complete-common))) ; show completion options

	(general-def prog-mode-map
		"TAB" #'company-indent-or-complete-common
		)
  )
; this prevents "company-capf: Marker does not point anywhere", by doing completion with this package
(use-package company-c-headers
	:config
	(add-to-list 'company-backends 'company-c-headers))
