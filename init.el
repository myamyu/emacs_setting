;;; init.el --- emacsの設定
;;; Commentary:
;;; Code:

(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;; cask
(require 'cask "~/.cask/cask.el")
(setq user_bundle (cask-initialize "~/.emacs.d"))
;;(cask-install user_bundle)
;;(cask-update  user_bundle)

;;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)
;;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)

;; key
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c i") 'helm-imenu)
(global-set-key (kbd "C-c o") 'org-capture)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x j") 'open-junk-file)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

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

;; 日本語入力
(when (require 'skk nil t)
  (setq default-input-method "japanese-skk")
  (require 'skk-study))
(require 'ac-ja)
(setq ac-sources (append ac-sources '(ac-source-dabbrev-ja)))

;; 見た目
(custom-set-variables
 '(column-number-mode t)
 '(display-time-mode t)
 '(inhibit-startup-screen t)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

;; hi-line
(require 'hl-line)
(defun global-hl-line-timer-function ()
  "Hilight line timer."
  (global-hl-line-unhighlight-all)
  (let ((global-hl-line-mode t))
    (global-hl-line-highlight)))
(run-with-idle-timer 0.03 t 'global-hl-line-timer-function)

;; フォント
(if *run-win*
    (progn
      (set-face-attribute 'default nil :family "Consolas" :height 130)
      (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Meiryo UI"))))

;; インデントなど
(setq-default
 default-tab-width 2
 indent-tabs-mode nil
 c-basic-offset 2
 c-tab-always-indent t
 c-auto-newline t
 c-hungry-delete-key t)

;; ignoramus
(require 'ignoramus)
(ignoramus-setup)

;; org-mode, junk
(require 'org)
(require 'open-junk-file)
(setq org-directory "~/org-memo/")
(defvar junk-directory (concat org-directory "junk/"))
(setq org-default-notes-file (concat org-directory "memo.org"))
(setq org-agenda-files (list
                        org-directory
                        junk-directory))
(setq open-junk-file-format (concat junk-directory "%Y-%m%d.org"))
(setq org-startup-folded nil)

;; projectile
(require 'projectile)
(custom-set-variables '(projectile-enable-caching t))
(projectile-global-mode t)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(add-to-list 'projectile-globally-ignored-directories "elpa")
(add-to-list 'projectile-globally-ignored-directories ".cache")
(add-to-list 'projectile-globally-ignored-directories "node_modules")
(add-to-list 'projectile-globally-ignored-directories ".sass-cache")

;; auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (locate-user-emacs-file "dict"))
(ac-config-default)
(define-key ac-complete-mode-map (kbd "C-n") 'ac-next)
(define-key ac-complete-mode-map (kbd "C-p") 'ac-previous)
(define-key ac-complete-mode-map (kbd "<tab>") 'ac-complete)

;; company
(require 'company)
(define-key company-active-map (kbd "M-n") nil)
(define-key company-active-map (kbd "M-p") nil)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-h") nil)
(define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
(define-key company-active-map (kbd "M-d") 'company-show-doc-buffer)
(setq company-idle-delay 0.2)
(setq company-minimum-prefix-length 2)
(setq company-selection-wrap-around t)
(setq company-auto-complete t)
(setq company-global-modes t)
(setq company-show-numbers t)
(add-to-list 'company-backends '(company-tern :with company-dabbrev-code))
(add-to-list 'company-backends 'ac-js2-company)

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))

;; undo-tree
(require 'undo-tree)
(global-undo-tree-mode)

;; js-mode
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js2-mode-hook
          '(lambda ()
             (tern-mode t)
             (flycheck-mode t)
             (setq flycheck-check-syntax-automatically '(save mode-enabled))
             (setq js2-mirror-mode t)
             (setq js2-auto-indent-p t)
             (setq js2-enter-indents-newline t)
             (setq js2-bounce-indent-flag nil)
             (company-mode)))

;; scss-mode
(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))
(add-hook 'scss-mode-hook
          '(lambda ()
             (setq css-indent-offset 2)
             (setq css-tab-mode 'indent)
             (setq indent-tabs-mode t)
             (auto-complete-mode)))

;; css-mode
(add-hook 'css-mode-hook
          '(lambda ()
             (setq css-indent-offset 2)
             (setq css-tab-mode 'indent)
             (setq indent-tabs-mode t)
             (auto-complete-mode)))
;; web-mode
(add-to-list 'auto-mode-alist '("\\.html?$" . web-mode))
(add-hook 'web-mode-hook
          '(lambda ()
             (setq web-mode-markup-indent-offset 2)
             (setq indent-tabs-mode t)
             (auto-complete-mode)))
;; typescript-mode
(require 'typescript-mode)
(require 'tide)
(add-to-list 'auto-mode-alist '("\\.ts$" . typescript-mode))
(add-hook 'typescript-mode-hook
          '(lambda ()
             (tide-setup)
             (flycheck-mode t)
             (setq flycheck-check-syntax-automatically '(save mode-enabled))
             (eldoc-mode t)
             (setq typescript-indent-level 2)
             (setq typescript-auto-indent-flag t)
             (company-mode)))
;; python-mode
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(add-hook 'python-mode-hook
          '(lambda ()
             (setq imenu-create-index-function 'python-imenu-create-index)
             (setq indent-tabs-mode nil)
             (setq indent-level 4)
             (setq python-indent 4)
             (setq python-indent-offset 4)
             (setq tab-width 4)
             (auto-complete-mode)))
;; ruby-mode
(require 'ruby-block)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-hook 'ruby-mode-hook
          '(lambda ()
             (ruby-electric-mode t)
             (ruby-block-mode t)
             (setq ruby-block-highlight-toggle t)
             (flycheck-mode t)))

(provide 'init)
;;; init.el ends here
