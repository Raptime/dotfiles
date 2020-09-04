;; init.el --- Emacs configuration

;; PACKAGES
;; --------------------------------------
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Package list
(setq package-selected-packages '(
				  nord-theme
				  lsp-mode
				  rust-mode
				  company
				  flycheck
				  which-key
				  ;; expand-region
				  ;; smartparens
				  ;; yasnippet
				  ;; yasnippet-snippets
				  ))

;; Install packages
(unless package-archive-contents
  (package-refresh-contents))
(package-install-selected-packages)

;; Theme
(load-theme 'nord t)

;; rust-mode
(require 'rust-mode)
(add-hook 'rust-mode-hook
	  (lambda () (setq indent-tabs-mode nil)))
(setq rust-format-on-save t)
(define-key rust-mode-map (kbd "C-c C-c") 'rust-compile)
(define-key rust-mode-map (kbd "C-c C-t") 'rust-test)

;; lsp-mode
(require 'lsp-mode)
(add-hook 'rust-mode-hook #'lsp)
(setq lsp-rust-server 'rust-analyzer)

;; which-key
(which-key-mode)

;; company
(setq company-idle-delay 0)

;; expand-region
;; (global-set-key (kbd "C-=") 'er/expand-region)

;; smartparens
;; (require 'smartparens-config)
;; (add-hook 'rust-mode-hook #'smartparens-mode)

;; yasnippet
;; (yas-reload-all)
;; (add-hook 'rust-mode-hook #'yas-minor-mode)

;; BASIC CUSTOMIZATION
;; --------------------------------------
(setq inhibit-startup-message t)        ; hide the startup message
(setq default-major-mode 'text-mode)    ; text mode for new buffers
(setq visible-bell t)                   ; disable the bell
(setq confirm-kill-processes nil)       ; kill processes on exit
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))
					; move backup folder

(defalias 'yes-or-no-p 'y-or-n-p)       ; replace yes or no with y or n

(save-place-mode 1)                     ; remember place in file
(show-paren-mode 1)                     ; show matching parenthesis
(delete-selection-mode 1)               ; allow selection replacement

(menu-bar-mode -1)                      ; hide menu bar
(tool-bar-mode -1)                      ; hide tool bar
(scroll-bar-mode -1)                    ; hide scroll bar
(horizontal-scroll-bar-mode -1)         ; hide horizontal scroll bar

;; Emoji fonts: 😄, 🤦, 🏴󠁧󠁢󠁳󠁣󠁴󠁿
(set-fontset-font t 'symbol "Noto Color Emoji")
(set-fontset-font t 'symbol "Apple Color Emoji" nil 'append)
(set-fontset-font t 'symbol "Segoe UI Emoji" nil 'append)
(set-fontset-font t 'symbol "Symbola" nil 'append)

;; FUNCTIONS
;; --------------------------------------
(defun iwb ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil))

;; KEY BINDINGS
;; --------------------------------------

;; (global-set-key (kbd "C-c <left>")  'windmove-left)
;; (global-set-key (kbd "C-c <right>") 'windmove-right)
;; (global-set-key (kbd "C-c <up>")    'windmove-up)
;; (global-set-key (kbd "C-c <down>")  'windmove-down)

;; init.el --- End of config
