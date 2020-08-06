;; init.el --- Emacs configuration

;; PACKAGES
;; --------------------------------------
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Rust
(require 'rust-mode)
(add-hook 'rust-mode-hook
          (lambda () (setq indent-tabs-mode nil)))
(setq rust-format-on-save t)
(setq lsp-rust-server 'rust-analyzer)
(define-key rust-mode-map (kbd "C-c C-c") 'rust-compile)
(define-key rust-mode-map (kbd "C-c C-t") 'rust-test)

;; Theme
(load-theme 'nord t)

;; BASIC CUSTOMIZATION
;; --------------------------------------
(setq inhibit-startup-message t)     ;; hide the startup message
(setq default-major-mode 'text-mode) ;; text mode for new buffers
(setq visible-bell t)                ;; disable the bell
(setq mouse-wheel-scroll-amount
      '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

(defalias 'yes-or-no-p 'y-or-n-p)    ;; replace yes or no with y or n

(save-place-mode 1)
(show-paren-mode 1)

(unless (eq window-system 'ns)
  (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(when (fboundp 'horizontal-scroll-bar-mode)
  (horizontal-scroll-bar-mode -1))

(unless backup-directory-alist
  (setq backup-directory-alist `(("." . ,(concat user-emacs-directory
                                                 "backups")))))

;; FUNCTIONS
;; --------------------------------------
(defun iwb ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil))

;; KEY BINDINGS
;; --------------------------------------

(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)

(global-set-key (kbd "C-x g")  'magit-status)


;; init.el --- End of config
