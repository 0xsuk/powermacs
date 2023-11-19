(use-package svg-clock
	:config
	(defun clock ()
		(interactive)
		(svg-clock)
		(setq-local cursor-in-non-selected-windows nil)
		(read-only-mode -1)
		)
	)

(use-package zone
	:ensure nil ; already installed by default
	:config
	(defun zone-choose (pgm)
    "Choose a PGM to run for `zone'."
    (interactive
     (list
      (completing-read
       "Program: "
       (mapcar 'symbol-name zone-programs))))
    (let ((zone-programs (list (intern pgm))))
      (zone)))
	)

;; TODO
;; (use-package bgex
	;; :quelpa (bgex :fetcher github :repo "wachikun/emacs_bgex")
	;; )



(use-package fireplace
	:config
	(setq
	 ;; fireplace-smoke-on t
	 fireplace-sound-on t
	 )
	)

(setq mode-line-format-backup mode-line-format)

(defun enable-anime ()
	(interactive)
	(popper-mode -1)
	(scroll-bar-mode -1)
	(hide-mode-line)
	)

(defun disable-anime ()
	(interactive)
	(popper-mode 1)
	(setq mode-line-format mode-line-format-backup)
	)

(defun clock-vterm-fireplace ()
	(interactive)
	(enable-anime)
	(purpose-load-window-layout "clock-vterm-fireplace")
	(other-window 1)
	(clock)
	(move-beginning-of-line 1)
	(open-line 2)
	(other-window 1)
	(vterm)
	(setq-local vterm-min-window-width (window-width)) ; for peaclock
	(setq-local cursor-in-non-selected-windows nil)
																				; run peaclock
	(other-window 1)
	(fireplace)
	)
