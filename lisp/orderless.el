; package for order-less filtering of completion candidates
(use-package orderless
	:config
	(setq 
	 ;; The completion-styles variable is a list of methods to use when trying to find a match for a completion request
	 completion-styles '(orderless)
	 completion-category-defaults nil ; important
	 orderless-matching-styles '(orderless-prefixes orderless-initialism)
	 )
	 )
