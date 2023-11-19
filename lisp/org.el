;; Org-mode


(use-package org
  :defer t
	:ensure nil
	:config
	(general-def org-mode-map
		"M-h" nil ; org-mark-element
		)
	)

(use-package org-noter
  :defer t
	:if (not ismac)
	:init
	(setq org-noter-always-create-frame nil)
	)

(use-package org-remark
  :defer t
	:if (not ismac))

