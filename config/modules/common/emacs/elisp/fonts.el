;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FONTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun font-exists-p (font)
  "Check if the font exists."
  (and (display-graphic-p) (not (null (x-list-fonts font)))))

(defun set-preferred-fonts (font-size)
  (cond
   ((font-exists-p "Source Code Pro")
    (set-face-attribute 'fixed-pitch nil :family "Source Code Pro" :height font-size)
    (set-face-attribute 'default nil :family "Source Code Pro" :height font-size)))

  (cond
   ((font-exists-p "Ubuntu")
    (set-face-attribute 'variable-pitch nil :family "Ubuntu" :height font-size))))

(set-preferred-fonts 180)
