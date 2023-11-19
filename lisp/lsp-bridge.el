(my-load-file "markdown.el")

(add-to-list 'load-path "/home/null/inst/lsp-bridge/")

(require 'posframe)

(require 'lsp-bridge)
(global-lsp-bridge-mode)

(general-def 'acm-mode-map
	"C-j" 'acm-select-next
	"C-k" 'acm-select-prev
	)
