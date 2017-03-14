;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults     ;; better defaults
    solarized-theme))   ;; save my eyes theme

(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'solarized-dark t)   ;; load solarized theme
(global-linum-mode t)            ;; enable line numbers globally
(column-number-mode t)           ;; Show column number as well as line

(setq default-major-mode 'text-mode) ;; text mode for new buffers
(defalias 'yes-or-no-p 'y-or-n-p)    ;; replace yes or no with y or n

(setq linum-format "%d ")	;; add a space after line numbers

(set-face-attribute 'default nil :height 80)

;; FUNCTIONS
;; --------------------------------------
(defun iwb ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

;; KEY BINDINGS
;; --------------------------------------

(global-set-key [f6]            'next-multiframe-window)
(global-set-key [f7]            'next-buffer)
(global-set-key [f12]           'iwb)

;; PYTHON CONFIGURATION
;; --------------------------------------

;;(elpy-enable)

;; init.el ends here
