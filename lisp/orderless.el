; package for order-less filtering of completion candidates
(use-package orderless
  :quelpa (orderless :fetcher github :repo "oantolin/orderless" :commit "6e3a09d6026fe7d7d5a3caf9a3d777cc9841fe80")
	:config
	(setq 
	 ;; The completion-styles variable is a list of methods to use when trying to find a match for a completion request
	 completion-styles '(orderless)
	 completion-category-defaults nil ; important
	 orderless-matching-styles '(orderless-literal orderless-regexp orderless-initialism)
	 )
	 )
