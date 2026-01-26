(defmacro my-profile (form)
  `(progn
     (profiler-start 'cpu+mem)
     (unwind-protect
         ,form
       (profiler-stop))
     (profiler-report)))
