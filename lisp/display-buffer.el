(defmacro if-major-mode-function (mode)
	'(lambda (buffer alist)
		 (with-current-buffer buffer
			 (eq major-mode ',mode))))

(defun my-display-function (buffer &optional alist)
	(message "mdf")
	(print alist))


; 試運転
(defun my-display-buffer-smart (buffer alist)
  "BUFFER を表示する window を賢く選ぶ display-buffer アクション."
  (let* ((buf   (get-buffer buffer))
         (mode  (buffer-local-value 'major-mode buf))
         (wins  (window-list nil 'no-minibuf))
         (cur   (selected-window))
         ;; 1. すでに表示されている window
         (same-buf-win
          (get-buffer-window buf 'visible))
         ;; 2. 同じ major-mode の window
         (same-mode-win
          (seq-find
           (lambda (w)
             (with-current-buffer (window-buffer w)
               (eq major-mode mode)))
           wins)))
    (cond
     ;; 1. 既に表示中ならそれを使う
     (same-buf-win
      (window--display-buffer buf same-buf-win 'reuse alist))

     ;; 2. 同じ major-mode の window を使う
     (same-mode-win
      (window--display-buffer buf same-mode-win 'reuse alist))

     ;; 3. window が1つだけなら分割して使う
     ((and (= (length wins) 1)
           (window-splittable-p cur))
      (let ((new-win (split-window-sensibly cur)))
        (when new-win
          (window--display-buffer buf new-win 'window alist))))

     ;; 4. window が2つ以上なら「どれか」を使う
     ((> (length wins) 1)
      (let* ((other
              (or (seq-find (lambda (w) (not (eq w cur))) wins)
                  cur)))
        (window--display-buffer buf other 'reuse alist)))

     ;; どうしても決まらなかったら nil を返す（他のアクションに委ねる）
     (t nil))))

(add-to-list 'display-buffer-alist
						 `(,(if-major-mode-function Man-mode)
							 (my-display-function)))
