;;; DESIGN
; modal editing keymaps should be composable.
; In some major mode, I want to enable specific set of keymaps (e.g. j,k for next/previous line), but don't want to enable other sets of keymaps (e.g. w,b for next/previous word)
;?; Remap global keys overriden by this mode. (e.g. C-f/C-n is overriden by l/j so )
; keymap precedence example, from low to high: global, vterm-mode-map, my-base-map, my-vertical-nav-map, my-base-(vterm-specific)-map, my-vertical-(vter-specific)-map
; another example, : global, dired-mode-map, my-vertical-nav-map, my-vertical-(dired)-map
; : global, magit-mode-map, magit..(someothermaps), my-vertical-nav-map, my-vertical-nav-(magit)-map

(define-minor-mode king-mode
	"king mode"
	:lighter " king"
	:keymap (let ((map (make-keymap)))
						(general-def map
							"i" 'king-mode
							"f" 'ignore)
						map)
	)

(global-set-key (kbd "<escape>") (my-l (king-mode 1)))

(make-variable-buffer-local
 (defvar king-active-states-list nil
	 "List of active king states"))

; base state map
(defvar king-base-map
	(let ((map (make-sparse-keymap)))
		(set-keymap-parent map my-mode-map)
		(general-def map
			"D" 'kill-line)))

(defvar my-vertcal-nav-map
	(let ((map (make-sparse-keymap)))
		(set-keymap-parent map my-mode-map)
		(general-def map
			"j" 'next-line
			"k" 'previous-line
			"C-j" 'my-scroll-down
			"C-k" 'my-scroll-up)))

(defun king-define-state (name overridep)
	"Define king state.")

(defun king-activate-state (state)
	"Activate king state.")

(defun king-set-states-for-mode (mode states)
	"Set state to activate for mode.")

(defun king-define-key (state keymap key def)
	"Define-key for king."
	(let))
