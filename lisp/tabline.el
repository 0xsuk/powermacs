; tab line
;; (global-tab-line-mode)
(setq tab-line-close-button-show nil
			tab-line-new-button-show nil
			tab-line-left-button nil
			tab-line-right-button nil)
(defcustom tab-line-tab-min-width 5
  "Minimum width of a tab in characters."
  :type 'integer
  :group 'tab-line)
(defcustom tab-line-tab-max-width 10
  "Maximum width of a tab in characters."
  :type 'integer
  :group 'tab-line)
(defun aorst/tab-line-name-buffer (buffer &rest _buffers)
  (with-current-buffer buffer
    (let* ((window-width (window-width (get-buffer-window)))
           (close-button-size (if tab-line-close-button-show
                                  (length (substring-no-properties tab-line-close-button))
                                0))
           (tab-amount (length (tab-line-tabs-window-buffers)))
           (window-max-tab-width (/ window-width tab-amount))
           (tab-width (- (cond ((>= window-max-tab-width tab-line-tab-max-width)
                                tab-line-tab-max-width)
                               ((< window-max-tab-width tab-line-tab-min-width)
                                tab-line-tab-min-width)
                               (t window-max-tab-width))
                         close-button-size))
           (buffer-name (string-trim (buffer-name)))
           (name-width (length buffer-name)))
			(if (>= name-width (- tab-width 3))
					(concat  " " (truncate-string-to-width buffer-name (- tab-width 3)) "… ")
				(let* ((padding (make-string (/ (- tab-width name-width) 2) ?\s))
							 (buffer-name (concat padding buffer-name))
							 (name-width (length buffer-name)))
					(concat buffer-name (make-string (- tab-width name-width) ?\s)))))))
(add-hook 'window-configuration-change-hook
          #'(lambda ()
              (dolist (window (window-list))
                (set-window-parameter window 'tab-line-cache nil))))
(setq tab-line-tab-name-function #'aorst/tab-line-name-buffer)
