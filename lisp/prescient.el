; package for sorting completion candidates
(use-package prescient
  :quelpa (prescient :fetcher github :repo "emacsmirror/prescient" :commit "ae414dde56f3430867faf41c04e4c3df75f9c960")
	;; :config
	;; I use orderless ;; (setq prescient-filter-method '(literal initialism)) ; don need regex
	;; (setq completion-category-overrides nil) ; then all falls back to completion-styles
	)


(use-package corfu-prescient
  :quelpa (corfu-prescient :fetcher github :repo "emacsmirror/prescient" :commit "ae414dde56f3430867faf41c04e4c3df75f9c960")
	;; :after (corfu orderless)
	:after corfu
	:config
	(setq
	 ; TODO: Enabling filtering gives unmatched candidates in sly!!
	 corfu-prescient-enable-filtering nil ; nil for orderless
	 corfu-prescient-override-sorting t ; use prescient to sort. in corfu setting corfu-sort-function to prescient-completion-sort (which corfu-prescient-mode does automatically) is not enough to change sorting function? tuning this on will set override function to that.
	;;  ;; corfu-prescient-completion-styles '(orderless) ; not sure if this is needed
	 )
	(corfu-prescient-mode))

(use-package vertico-prescient
  :quelpa (vertico-prescient :fetcher github :repo "emacsmirror/prescient" :commit "ae414dde56f3430867faf41c04e4c3df75f9c960")
	:after vertico
	:config
	(setq
	 vertico-prescient-enable-filtering nil ; nil for orderless
	 )
	(vertico-prescient-mode))
