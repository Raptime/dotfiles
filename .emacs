;; Paths
(add-to-list 'load-path "~/.emacs.d/scripts/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;; Remove menu
(menu-bar-mode -1)
;;(toggle-scroll-bar -1)
;;(tool-bar-mode -1)

;; Remove startup message
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-message t)

;; Cosmetics
(column-number-mode t)
(global-font-lock-mode t)
(show-paren-mode t)
(transient-mark-mode t)
(setq-default indent-tabs-mode nil)
(setq my_msg (concat "Welcome " (user-full-name)))
(set-fill-column 80)

;; Backup files
(setq backup-directory-alist `(("." . "~/.emacs.d/saves")))
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; Make text mode the default for new buffers
(setq default-major-mode 'text-mode)

;; Functions
(defun iwb ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

;; Key Bindings
(global-set-key [f2]            'save-buffer)
(global-set-key [f3]            'find-file)
(global-set-key [f6]            'next-multiframe-window)
(global-set-key [f12]           'iwb)
(global-set-key [delete]        'delete-char)
(global-set-key [home]          'beginning-of-line)
(global-set-key [end]           'end-of-line)

;; Load theme
(load-theme 'zenburn t)
