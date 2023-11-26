(use-package general
  :config
	(general-override-mode)
	)

(general-def 'global
  "C-a" 'crux-move-beginning-of-line
	";"
	(general-key-dispatch 'self-insert-command
		;; :timeout 0.35
		";" (my-l)
		"e" (my-l (self-insert-command 1 ?\;))
		"w" (my-l (if (eq major-mode 'python-mode)
									(progn (insert "''") (backward-char))
								(insert "'")))
    "r" (my-l (insert "#"))
		"t" (my-l (insert "%"))
    "y" (my-l)
		"u" (my-l (insert "#'"))
    "i" (my-l (insert "**") (backward-char 1)
                                        ; bind next insertion of "space" to forward-char
              )
    "o" (my-l)
    "p" (my-l)
    "@" (my-l)
    "[" (my-l)
		"a" (my-l (insert "&")) ; pointer
		"s" (my-l (insert "\"\"") (backward-char))
		"d" (my-l (end-of-line) (insert ";"))
		"f" (my-l (insert "()") (backward-char))
		"g" (my-l (insert " = "))
    ;; "h" (my-l (end-of-line) (insert ";"))
		"j" (my-l (insert "_"))
    "k" (my-l)
    "l" (my-l (insert "(lambda ())") (backward-char 2))
    "z" (my-l)
    "x" (my-l)
		"c" 'my-insert-curly-brackets-at-end
    "v" (my-l (insert "->"))
    "b" (my-l)
    "n" (my-l (insert "#'"))
    "m" 'my-insert-dot
		)
	;; "/" (general-key-dispatch 'self-insert-command
				;; "a" (my-l (self-insert-command 1 ?A))
				;; "b" (my-l (self-insert-command 1 ?B))
				;; "c" (my-l (self-insert-command 1 ?C))
				;; "d" (my-l (self-insert-command 1 ?D))
				;; "e" (my-l (self-insert-command 1 ?E))
				;; "f" (my-l (self-insert-command 1 ?F))
				;; "g" (my-l (self-insert-command 1 ?G))
				;; "h" (my-l (self-insert-command 1 ?H))
				;; "i" (my-l (self-insert-command 1 ?I))
				;; "j" (my-l (self-insert-command 1 ?J))
				;; "k" (my-l (self-insert-command 1 ?K))
				;; "l" (my-l (self-insert-command 1 ?L))
				;; "m" (my-l (self-insert-command 1 ?M))
				;; "n" (my-l (self-insert-command 1 ?N))
				;; "o" (my-l (self-insert-command 1 ?O))
				;; "p" (my-l (self-insert-command 1 ?P))
				;; "q" (my-l (self-insert-command 1 ?Q))
				;; "r" (my-l (self-insert-command 1 ?R))
				;; "s" (my-l (self-insert-command 1 ?S))
				;; "t" (my-l (self-insert-command 1 ?T))
				;; "u" (my-l (self-insert-command 1 ?U))
				;; "v" (my-l (self-insert-command 1 ?V))
				;; "w" (my-l (self-insert-command 1 ?W))
				;; "x" (my-l (self-insert-command 1 ?X))
				;; "y" (my-l (self-insert-command 1 ?Y))
				;; "z" (my-l (self-insert-command 1 ?Z))
				;; "/" (my-l (self-insert-command 1 ?/)))
	"C-0" 'my-search-space
	"C-8" 'my-search-leftparen
	"C-9" 'my-search-rightparen
  ;; "C-h" 'previous-buffer
  ;; "C-l" 'next-buffer
  "<C-i>" 'avy-goto-char-2
  "C-v" nil
  "C-v h" 'lsp-ui-doc-toggle
  "C-v f" 'lsp-ui-doc-focus-frame
  "C-v d" 'er/mark-defun
  "C-v o" 'other-frame
  "C-v C-k" 'comint-kill-input
	"C-j" 'default-indent-new-line
	;; "C-k" 'crux-kill-and-join-forward
	"C-x w" 'elfeed
	"C-x C-t" (my-l (message (file-name-directory buffer-file-name))) ;before: transpose-line
	"C-x j" 'purpose-switch-buffer ; bef:quit-window
	"C-c C-j" 'eval-defun
	"C-x C-r" 'eval-region ; bef:find-file-read-only
	;; "C-x C-d" 'consult-dir ; bef:dired
	;; "C-x d" 'dired ; list-directory
	"M-u" 'mark-sexp ; bef:upcase-word
	"C-/" 'winner-undo
  "C-?" 'lsp-treemacs-call-hierarchy
	"C-\\" 'winner-redo ; toggle-input-method not freq
  "M-/" 'window-configuration-to-register
	"M-;" 'comment-line ; better than comment-dwim
	;; "M-:" 'eval-expression ;bef:eval-expression
	;; "C-x C-e" 'eval-last-sexp ; bef:eval-last-sexp
	"C-z" 'async-shell-command ; suspend-frame, useless
	"M--" 'point-history-show ; negative arg, use C--
	"C-;" 'find-file; undefined
  "C-+" 'projectile-find-file
	;; "M-@" 'er/mark-word
	"M-e" 'er/expand-region ;bef: forward-sentence
	"M-r" 'er/contract-region ; undefined
	"M-RET" 'crux-smart-open-line ; undefined
	"M-o" 'crux-smart-open-line-above; undefined
	"M-i" 'paredit-forward-slurp-sexp ; tab-to-tab-stop
	"TAB" 'indent-for-tab-command ; has to be re-bound because of C-i
	"C-q" 'pop-to-mark-command ;quoted-insert, not used freq
	"M-l" 'windmove-right ; downcase word
	"M-h" 'windmove-left ; mark-paragraph
	"M-j" 'windmove-down ; default-indent-new-line
	"M-k" 'windmove-up ;kill-sentence
	"M-q" 'kill-current-buffer ; bef:kill-paragraph
	;; "M-y" 'counsel-yank-pop
	;; "M-s" 'swiper ; bef : some prefix
	"M-s" 'consult-line
	"M-[" 'backward-sexp ; undefined
	"M-]" 'forward-sexp ; undefined
	"C-\"" 'undo-tree-undo ; undefined
	"<C-[>" 'undo-tree-redo ; abort-recursive-edit ?? dunno what
	"M-0" nil
	;;; free keys
	;; "C-x C-j"  ; use C-j
	;; "C-." 'counsel-switch-buffer

	;; "C-l" 
	"C-," (lambda () (interactive)
          (consult-buffer '(consult--major-mode-buffers)))
  "C-`" 'consult-dir
	"C-." 'consult-buffer
  "C->" nil
  "C-@" nil
  "C-x C-." 'consult-lsp-symbols
	"C-x C-o" 'delete-other-windows ; delete-blank-lines
	"C-x C-f" 'projectile-find-file ; find-file use C-;
	"C-x C-;" 'eval-defun ; bef: comment-line use M-; instead
	"C-x C-u" 'delete-frame ; bef:upcase-region, use M-u
	"C-x d" 'paredit-splice-sexp ; dired use dired-jump instead
	"C-x i" 'make-frame ; insert-file (inserts content of file)
	"C-x C-SPC" nil ; pop-global-mark ; same as C-x C-@
	"C-x C-n" 'my-max-popper-window ; set-goal-column no use probably
	;; "C-x o" nil ; other-window useless ; save in case M-<> overriden
	"M-g c" nil ; bef:goto-char useless
	"M-g M-g" nil ; bef:goto-line same as M-g g
	"M-g M-n" nil ; bef:next-error same as M-g n
	"M-g M-p" nil ; bef:prev-error same as M-g p
	;; "M-z" nil ;bef:zap-to-char, better use meow
	"M-c" 'upcase-region ;bef:capitalize-word useless (because it affect only the first letter)
	"M-t" nil ; bef:transpose-word
	"M-v" 'paredit-forward-down ; scroll-down-command useless
	"M-a" nil ; bef: backward-sentence
	"M-p" 'backward-sexp
	"M-n" 'forward-sexp ; undefined
	"C-t" (my-l (point-to-register ?@)) ;transpose-chars useless
  "C-S-t" (my-l (jump-to-register ?@))
	;; "C-<return>" nil ; undefined
	"C-(" 'popper-toggle-latest
  "C-:" 'completion-at-point
	"C-*" 'cape-dabbrev; undefined
	"C-^" 'my-max-popper-window ; undefined~~^^^^^^^^^
	"C-M--" nil ;	use C--
	;;; new prefixes candidates
	"M-SPC" 'set-mark-command ; bef:just-one-space same as C-SPC though
	"C-<escape>" nil; undefined
	"M-ESC" nil ; no usecase
	;;;
	;; "C-S-b" 'backward-sexp
	;; "C-S-n" 'forward-list
	;; "C-S-p" 'backward-list
	;; "C-S-f" 'forward-sexp ; not working!!!
  "C-S-w" 'window-configuration-to-register
  "C-S-m" 'point-to-register
  "C-S-r" 'consult-register
  "C-S-j" (my-l (text-scale-increase 1))
  "C-S-k" (my-l (text-scale-decrease 1))
  "C-S-l" (my-l (text-scale-increase 0))
	)

(general-create-definer leader-spc
  :prefix "<f12>")
(leader-spc
	:keymaps 'global
  "c" 'corfu-mode
	"p" 'popper-mode
	"C" 'centered-window-mode
  "i" 'consult-imenu ; indent-for-tab-command, use TAB instead
	"bi" (my-l (find-file "~/.emacs.d/init.el"))
	"bs" (my-l (switch-to-buffer "*scratch*"))
	"bm" (my-l (switch-to-buffer "*Messages*"))
	"v" 'vterm
	"r" 'consult-ripgrep
	"j" 'my-split-and-move-down
  "k" 'split-window-below
	"l" 'my-split-and-move-right
  "h" 'split-window-right
	"dc" (my-l (cd (file-name-directory buffer-file-name)))
	"dd" (my-l (cd default-directory))
	"o" 'ace-window
	"m" 'imenu-anywhere
	"e" 'my-eshell-or-projectile-eshell
	"g" 'toggle-input-method
  "<f12> b" 'fix-bindings
	)

(general-def read-expression-map "C-j" nil) ; use C-j to new line without evaluation in Eval:
