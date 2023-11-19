(defun sc-stop ()
	(interactive)
	(call-interactively 'sly-mrepl)
	(insert "(stop)")
	(sly-mrepl-return))

(defun sly-documentation-supercollider (ugen)
  (interactive (list
                (completing-read "Class: " (sly-supercollider-get-ugens-list) nil nil)))
  (eww (concat "http://doc.sccode.org/Classes/" ugen ".html")))

(defvar sly-supercollider-ugens-list nil)

(defun sly-supercollider-get-ugens-list ()
  (if (null sly-supercollider-ugens-list)
      (progn
        (with-temp-file "/tmp/supercollider-get-ugens-list.scd"
          (insert "\"-----\".postln;Object.allSubclasses.do(_.postcs);\"-----\".postln;0.exit;"))
        (with-temp-buffer
          (call-process-shell-command "sclang /tmp/supercollider-get-ugens-list.scd" nil t nil)
          (goto-char (point-min))
          (search-forward "\n-----\n")
          (setf sly-supercollider-ugens-list
                (sort (split-string (buffer-substring-no-properties (point) (- (save-excursion (search-forward "\n-----\n") (point)) 6)) "\n" t) #'string<))))
    sly-supercollider-ugens-list))

(general-def sly-mode-map
	"C-c C-." 'sc-stop
	"C-c h" 'sly-documentation-supercollider)
