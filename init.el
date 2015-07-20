;; server
(add-hook 'server-visit-hook
	  (lambda ()
	    (set-terminal-coding-system 'utf-8)
	    (set-keyboard-coding-system 'utf-8)))
(require 'server)
(unless (server-running-p)
  (server-start))

;; OS判定
(defvar *run-unix*
  (or (equal system-type 'gnu/linux)
      (equal system-type 'darwin)
      (equal system-type 'usg-unix-v)))
(defvar *run-win*
  (and (null *run-unix*)
       (or (equal system-type 'windows-nt)
	   (equal system-type 'ms-dos))))

;; 文字コード
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)

;; package
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; load-path
(setq load-path
      (append
       (list
        (expand-file-name "~/.emacs.d/elisp"))
       load-path))

;; インデントなど
(setq-default
 default-tab-width 2
 indent-tabs-mode nil
 c-tab-always-indent t
 c-auto-newline t
 c-hungry-delete-key t)

;; 見た目
(custom-set-variables
 '(column-number-mode t)
 '(display-time-mode t)
 '(inhibit-startup-screen t)
 '(tool-bar-mode nil))
(if *run-win*
    (progn
      (set-face-attribute 'default nil :family "Consolas" :height 130)
      (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Meiryo UI"))))

;; key
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)

;; auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(ac-config-default)

;; 日本語入力
(when (require 'skk nil t)
  (global-set-key (kbd "C-x j") 'skk-auto-fill-mode)
  (setq default-input-method "japanese-skk")
  (require 'skk-study))
(require 'ac-ja)
(setq ac-sources (append ac-sources '(ac-source-dabbrev-ja)))

;; js-mode
;; (add-to-list 'auto-mode-alist '("\\.js$" . js-mode))
(add-hook 'js-mode-hook
          '(lambda ()
             (setq js-indent-level 2)
             (setq js-basic-offset 2)
             (auto-complete-mode)))
;; js2-mode
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js2-mode-hook
          '(lambda ()
             (setq js-indent-level 2)
             (setq js2-basic-offset 2)
             (auto-complete-mode)))
             
