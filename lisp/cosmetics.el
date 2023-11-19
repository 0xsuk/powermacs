(use-package dashboard
	:config
	(dashboard-setup-startup-hook)
	(setq dashboard-banner-logo-title "'((((((((()))))))))")
  (setq dashboard-items '((recents . 15)))
  (setq dashboard-startup-banner 'logo
        dashboard-banner-logo-png "/home/null/archive/truth.jpg")
	)

; !!this should be called before theme load
(use-package centered-window
	:config
	(centered-window-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode)) ; for any *prog*ramming language mode

;; (use-package dimmer
	;; :config
	;; (setq dimmer-percent 0.4)
	;; (dimmer-mode))

;; (use-package gruber-darker-theme
;; 	:config
;; 	(load-theme 'gruber-darker))

;; (use-package doom-themes
;;   ;; doom-feather-dark
;;   ;; doom-monokai-machine
;;   :config
;;   ;; (load-theme 'doom-feather-dark)
;; 	;; (load-theme 'doom-monokai-machine)
;; 	(setq ring-bell-function 'doom-themes-visual-bell-fn) ; beep!
;;   )

;; (use-package nyan-mode
	;; :config
	;; (nyan-mode)
	;; (setq nyan-animate-nyancat t
				;; nyan-bar-length 16)
;; )

(use-package ef-themes
	:config
	(load-theme (if islaptop 'ef-frost 'ef-dark))
	(setq ef-themes-to-toggle '(ef-frost ef-dark))
	)
;; (use-package twilight-anti-bright-theme
	;; :config
	;; (load-theme 'twilight-anti-bright)
	;; )



; workspace
;; (use-package perspective
	;; :init
	;; (persp-mode))

;; (use-package tao-theme
;; 	:init
;; 	(setq tao-theme-use-sepia nil) ; use black yin
;; 	(setq tao-theme-use-boxes nil) ; does not mark function in box
;; 	(load-theme 'tao-yin)
;; 	)
