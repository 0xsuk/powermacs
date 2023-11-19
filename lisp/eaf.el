(use-package eaf
  :defer 2
	; install manually
	; make sure you use cpython
	; pythonqt is installed in ~/.local/lib/python3.10/
	; to resolve "qt.qpa.plugin: Could not load the Qt platform plugin "xcb" in "" even though it was found."
	; find out which dependency xcb is missing
	; ldd /home/null/.local/lib/python3.10/site-packages/PyQt6/Qt6/plugins/platforms/libqxcb.so | grep not
	; in my case it was libxcb-cursor.so.0
	; sudo nala install libxcb-cursor0
	:ensure nil
	:load-path "~/inst/emacs-application-framework/"
	:config
  (message "loading eaf")
	(require 'eaf-browser)
	(require 'eaf-file-sender)
	(require 'eaf-airshare)
	(require 'eaf-mindmap)
	(require 'eaf-rss-reader)
	;; (require 'eaf-image-viewer)
	(require 'eaf-music-player)
	(require 'eaf-video-player)
	(require 'eaf-system-monitor)
	;; (require 'eaf-2048) ; broken
  (message "eaf has been loaded")
	)

