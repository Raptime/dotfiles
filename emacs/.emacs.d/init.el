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

;; BASIC CUSTOMIZATION
;; --------------------------------------
(setq inhibit-startup-message t)     ;; hide the startup message
(setq default-major-mode 'text-mode) ;; text mode for new buffers
(setq visible-bell t)                ;; disable the bell
(setq linum-format "%d ")            ;; add a space after line numbers

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

(global-set-key [f2]            'save-buffer)
(global-set-key [f3]            'find-file)
(global-set-key [f4]            'kill-this-buffer)
;;(global-set-key [f5]            'open-new-frame)
(global-set-key [f6]            'next-multiframe-window)
(global-set-key [f7]            'next-buffer)
(global-set-key [f12]           'iwb)
