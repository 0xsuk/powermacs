;; PDF-TOOLS

(defvar my-pdf-bookmarks nil)
(defconst my-default-bookmark ?m)
(defun my-save-pdf-position (&optional b)
	(interactive)
	(unless b (setq b my-default-bookmark))
	(setf (alist-get b my-pdf-bookmarks)
				(pdf-view-bookmark-make-record))
	(message "Saved marker %s" (string b)))
(defun my-load-pdf-position (&optional b)
	(interactive)
	(unless b (setq b my-default-bookmark))
	(pdf-view-bookmark-jump (alist-get b my-pdf-bookmarks))
	(message "Loaded marker %s" (string b)))


																				; create skeleten with outline and highlighting
																				; basically use highlighting feature of pdf-tools.
																				; if something does not make sense, grab those text, "i" to insert and make it TODO
																				; it TODO makes sense make it DONE with explanation
																				; C-c C-a l to list highlighting
																				; C-s to search TODO

; IF PDF-TOOLS is slow after resize, try reverting a buffer with g
(use-package pdf-tools
  :defer 0.1
	:config
	(add-hook 'pdf-view-mode-hook (my-l (pdf-view-midnight-minor-mode)
																			(centered-window-mode -1) ; does not work well (first page becomes laggy)
																			(scroll-bar-mode -1)
																			))
	(defun my-pdf-exit ()
		(interactive)
		(centered-window-mode 1)
		(scroll-bar-mode 1))
	(setq org-noter-doc-split-fraction '(0.7 . 0.3))
	(pdf-tools-install) ; if this fails, do autoreconf in ../elpa/pdf-tools-20230404.327/build/server/. detail https://github.com/politza/pdf-tools/issues/142
	;; (evil-set-initial-state 'pdf-view-mode 'emacs)

	;https://www.reddit.com/r/emacs/comments/8uu7hb/question_pdftools_use_alot_of_ram/
	(setq pdf-cache-image-limit 1)
	(setq pdf-cache-prefetch-delay 5)
	(setq image-cache-eviction-delay 15)
	;

  (setq pdf-view-resize-factor 1.1)

  
	;; (setq pdf-view-continuous nil) ; t for continuous on mouse scroll
	(general-def 'pdf-view-mode-map
		"C-n" 'image-next-line ; also meow's j
		"C-p" 'image-previous-line ; also meow's k
		"n" 'pdf-view-scroll-up-or-next-page
		"p" 'pdf-view-scroll-down-or-previous-page
		"C-j" 'pdf-view-next-page
		"C-k" 'pdf-view-previous-page)
	
	;midnight
	(setq pdf-view-midnight-colors '("#ffffff" . "black")) ; get the background color using describe-face -> default -> background
	(setq-local cursor-in-non-selected-windows nil)

	;; 	"m" 'my-save-pdf-position
	;; 	"`" 'my-load-pdf-position
	;; 	"M-m" (lambda (b) (interactive "cBookmark Name: ") (my-save-pdf-position b))
	;; 	"M-`" (lambda (b) (interactive "cBookmark Name: ") (my-load-pdf-position b))
	;; 	;
	;; 	"<escape>" 'keyboard-quit
	;; 	"gl" 'evil-window-right
	;; 	"gh" 'evil-window-left
	;; 	"gj" 'evil-window-down
	;; 	"gk" 'evil-window-up
	;; 	"j" 'image-next-line
	;; 	"k" 'image-previous-line
	;; 	"M-j" 'pdf-view-next-line-or-next-page
	;; 	"M-k" 'pdf-view-previous-line-or-previous-page
	;; 	"n" 'pdf-view-scroll-up-or-next-page
	;; 	"p" 'pdf-view-scroll-down-or-previous-page
	;; 	"C-j" 'pdf-view-next-page
	;; 	"C-k" 'pdf-view-previous-page
	;; 	"=" (my-l (pdf-view-enlarge 1.1))
	;; 	"-" (my-l (pdf-view-enlarge 0.9))
	;; 	"h" 'pdf-view-fit-height-to-window
	;; 	"w" 'pdf-view-fit-width-to-window
	;; 	"<" (my-l (image-scroll-left 1))
	;; 	">" (my-l (image-scroll-right 1))
	;; 	"C-d" (my-l (pdf-view-next-page 10))
	;; 	"C-b" (my-l (pdf-view-previous-page 10))
	;; 	"gp" 'pdf-view-goto-page 
	;; 	"C-s" 'pdf-occur
	;; 	"i" 'org-noter-insert-note
	;; 	"M-i" 'org-noter-insert-precise-note
	;; 	"C-c s" 'org-store-link ; C-c M-l to insert
	;; 	)

	;; (general-def 'normal 'pdf-occur-buffer-mode-map
	;; 	"RET" 'pdf-occur-view-occurrence  ; goto-occurence (active in insert mode) leaves buffer
	;; 	)
	;; (general-def 'normal pdf-annot-list-mode-map
	;; 	"RET" 'pdf-annot-list-display-annotation-from-id)
	)

																				; - org-noter-insert-note becomes better: heading of selected text, but can't insert without nothing
(use-package org-pdftools
	:hook (org-mode . org-pdftools-setup-link))

(use-package org-noter-pdftools
	:after org-noter
	:config

	(defun org-noter-pdftools-insert-precise-note (&optional toggle-no-questions)
    (interactive "P")
    (org-noter--with-valid-session
     (let ((org-noter-insert-note-no-questions (if toggle-no-questions
                                                   (not org-noter-insert-note-no-questions)
                                                 org-noter-insert-note-no-questions))
           (org-pdftools-use-isearch-link t)
           (org-pdftools-use-freepointer-annot t))
       (org-noter-insert-note (org-noter--get-precise-info)))))

  ;; fix https://github.com/weirdNox/org-noter/pull/93/commits/f8349ae7575e599f375de1be6be2d0d5de4e6cbf
  (defun org-noter-set-start-location (&optional arg)
    "When opening a session with this document, go to the current location.
With a prefix ARG, remove start location."
    (interactive "P")
    (org-noter--with-valid-session
     (let ((inhibit-read-only t)
           (ast (org-noter--parse-root))
           (location (org-noter--doc-approx-location (when (called-interactively-p 'any) 'interactive))))
       (with-current-buffer (org-noter--session-notes-buffer session)
         (org-with-wide-buffer
          (goto-char (org-element-property :begin ast))
          (if arg
              (org-entry-delete nil org-noter-property-note-location)
            (org-entry-put nil org-noter-property-note-location
                           (org-noter--pretty-print-location location))))))))
  (with-eval-after-load 'pdf-annot
    (add-hook 'pdf-annot-activate-handler-functions #'org-noter-pdftools-jump-to-note)))

(use-package pdf-view-restore
	:after pdf-tools
	:config
	(add-hook 'pdf-view-mode-hook 'pdf-view-restore-mode))

