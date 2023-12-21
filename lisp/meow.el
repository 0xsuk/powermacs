(defun meow-setup ()
	(setq meow-expand-hint-remove-delay 0)
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
	;; (setq meow-full-width-number-position-chars '((0 . "0")
																								;; (1 . "1")
																								;; (2 . "2")
																								;; (3 . "3")
																								;; (4 . "4")
																								;; (5 . "5")
																								;; (6 . "6")
																								;; (7 . "7")
																								;; (8 . "8")
																								;; (9 . "9")))
  (meow-motion-overwrite-define-key ; overriden key of major mode map will AUTOMATICALLY rebound to H-<key>
   '("j" . meow-next)
   '("k" . meow-prev)
	 '("J" . my-scroll-down)
	 '("K" . my-scroll-up)
	 '("|" . meow-normal-mode)
	 '("<escape>" . ignore)
   )
  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION state.
   '("j" . "H-j")
   '("k" . "H-k")
	 '("J" . "H-J")
	 '("K" . "H-k")
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
	 '("n" . my-next-defun)
	 '("p" . beginning-of-defun)
   '("N" . my-scroll-super-down)
	 '("P" . my-scroll-super-up)
   '("y" . meow-yank)
	 '("|" . meow-motion-mode)
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse) ; ;x to move to the beginning of line
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("\"" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . backward-word)
   ;; '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   ;; '("e" . meow-next-word)
	 '("e" . forward-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find) ; -f to search back
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   ;; TODO grab "text" like o;; '("H" . find-)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
	 '("J" . my-scroll-down)
	 '("K" . my-scroll-up)
   ;; '("J" . meow-next-expand) ; use C-n
   '("k" . meow-prev)
   ;; '("K" . meow-prev-expand) ; use C-p
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("o" . meow-block) ; go to matching paren
   '("O" . meow-to-block)
   ;; '("p" . meow-yank) ; paste
	 ;; '("P" . meow-clipboard-yank)
   ;; '("q" . meow-quit)
   '("q" . quit-window)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   ;; '("u" . meow-undo)
	 ;; '("u" . meow-clipboard-save)
   '("U" . meow-undo-in-selection) ; no difference with C-/
   '("v" . meow-mark-point)
   '("w" . meow-mark-word)
	 '("(" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-line-expand) ; TODO not expected behaviour
   '("u" . meow-save) ; C-w
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
	 '("?" . repeat)
	 '("<up>" . my-scroll-up)
	 '("<down>" . my-scroll-down)
   '("<escape>" . save-buffer) ; TODO C-[ is not escape!
	 ;; '("<C-[>" . 'previous-buffer)
	 '("S" . nil)
	 '("C" . nil)
	 '("M" . nil)
	 '("W" . nil)
	 '("T" . nil)
	 '("'" . nil)
	 '("%" . nil)
	 '(":" . meow-pop-selection)
	 '("\\" . nil)
	 '("/" . repeat)
	 ;; '("SPC" . meow-mark-point)
	 ;; '("SPC" . meow-expand)
		))

(defun meow-mark-point ()
	"Mark point"
	(interactive)
	(if (region-active-p)
      (thread-first
				; '(expand . char) expands char (similar to "L"/"H")
				; '(expand . word) expands word (same as "we")
				; '(select . word) does not expand (same as "ee")
        (meow--make-selection '(expand . char) (mark) (point))
        (meow--select))
    (when meow-use-cursor-position-hack
      (forward-char 1))
    (thread-first
      (meow--make-selection '(expand . char) (point) (point))
      (meow--select))))

(use-package meow
	:config
	(meow-setup)
	(define-key meow-keymap [remap describe-key] 'helpful-key)
	(meow-global-mode 1)
	(setq meow-mode-state-list
				'((man-mode . normal)
          (authinfo-mode . normal)
					(beancount-mode . normal)
					(bibtex-mode . normal)
					(cider-repl-mode . normal)
					(cider-test-report-mode . normal)
					(cider-browse-spec-view-mode . motion)
					(cargo-process-mode . normal)
					(conf-mode . normal)
					(deadgrep-edit-mode . normal)
					(deft-mode . normal)
					(diff-mode . normal)
					(ediff-mode . motion)
					(gud-mode . normal)
					(haskell-interactive-mode . normal)
					(help-mode . normal)
					(helpful-mode . normal)
					(json-mode . normal)
					(jupyter-repl-mode . normal)
					(eww-mode . normal)
					(mix-mode . normal)
					(occur-edit-mode . normal)
					(pass-view-mode . normal)
					(prog-mode . normal)
					(py-shell-mode . normal)
					(restclient-mode . normal)
					(telega-chat-mode . normal)
					(term-mode . normal)
					(text-mode . normal)
					(eshell-mode . insert)
					(vterm-mode . insert)
					(pdf-view-mode . motion)
					(sly-db-mode . insert)
					(Custom-mode . normal)))
	(setq meow-use-clipboard t)

	(defun my-before-meow-insert-exit (&rest args)
		(corfu-quit)
		(when (eq major-mode 'vterm-mode)
			(vterm-copy-mode 1)
			)
		)
	(advice-add 'meow-insert-exit :before 'my-before-meow-insert-exit)

	(defun my-before-meow-insert (&rest args)
		(when (eq major-mode 'vterm-mode)
			(vterm-copy-mode -1))
		)
	(advice-add 'meow-insert :before 'my-before-meow-insert)
	)
