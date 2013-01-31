;; win判定
(defvar run-windows
  (or (equal system-type 'windows-nt)
      (equal system-type 'ms-dos)))

;; ---------------------------------------------------------
;; 文字コード
;; ---------------------------------------------------------
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(setq default-file-name-coding-system 'cp932)
(setq file-name-coding-system 'cp932)
(setq locale-coding-system 'cp932-dos)

;; ---------------------------------------------------------
;; パッケージ設定
;; ---------------------------------------------------------
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
;; auto-install
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")
(setq load-path (append (list
			 (expand-file-name "~/.emacs.d/auto-install")
			 )
			load-path))
;;(auto-install-update-emacswiki-package-name t)

;; init-loader
(require 'init-loader)
(init-loader-load "~/.emacs.d/init-load/")

;; ---------------------------------------------------------
;; server
;; ---------------------------------------------------------
(require 'server)
(unless (server-running-p) (server-start))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(column-number-mode t)
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(display-time-mode t)
 '(inhibit-startup-screen t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "ＭＳ ゴシック" :foundry "outline" :slant normal :weight normal :height 120 :width normal)))))
