;;; init.el --- emacsの設定
;;; Commentary:
;;; Code:

(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;; cask
(require 'cask "~/.cask/cask.el")
(cask-initialize "~/.emacs.d")

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
(require 'skk)
(setq default-input-method "japanese-skk")
(setq skk-user-directory "~/.emacs.d/skk")
(setq skk-jisyo "~/.emacs.d/skk/jisyo")
;; 変換時に注釈 (annotation) を表示する
(setq skk-show-annotation t)
;; 変換候補をtooltipにする
(setq skk-show-tooltip t)
(setq skk-show-inline t)
;; 送り仮名が厳密に正しい候補を優先して表示する
(setq skk-henkan-strict-okuri-precedence t)
;; 辞書登録のとき、余計な送り仮名を送らないようにする
(setq skk-check-okurigana-on-touroku 'auto)
;; 動的な補完を使う
(setq skk-dcomp-activate t)
;; 動的補完で候補を複数表示する
(setq skk-dcomp-multiple-activate t)
(require 'skk-study)
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
(setq projectile-globally-ignored-directories
      (append projectile-globally-ignored-directories '(".git"
							".cache"
							"node_modules"
							".sass-cache")))
(projectile-global-mode 1)

;; auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (locate-user-emacs-file "ac-dict/"))

(ac-config-default)
(global-auto-complete-mode t)
(setq ac-auto-show-menu 0.3)
(setq ac-use-menu-map t) ;; C-n/C-pで選択
(define-key ac-complete-mode-map (kbd "<tab>") 'ac-complete)

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
             (flycheck-mode t)
             (setq flycheck-check-syntax-automatically '(save mode-enabled))
             (setq js2-mirror-mode t)
             (setq js2-auto-indent-p t)
             (setq js2-enter-indents-newline t)
             (setq js2-bounce-indent-flag nil)
             (auto-complete-mode)))

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
             (auto-complete-mode)))
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
