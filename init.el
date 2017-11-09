; Settings for ...
; 0. packages
; 1. display at start -dashboard
; 2. Color -alpha-toggle
; 3. editting
; 4. bars -powerline
; 5. keybinds
; 6. history
; 7. others

;------------------------------
; 0. packages
;-----------------------------
(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

;;; Settings for packages
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;---------------------------------
; 1. display at start
;---------------------------------

;;; disable "splash screen"
(setq inhibit-splash-screen t)
;;; disable "start-up" display
(setq inhibit-startup-message t)
;;; split-window at start
(add-hook 'after-init-hook (lambda()
    (setq w (selected-window))
    (setq w2 (split-window w (- (window-height w) 10)))
    (select-window w2)
    (shell)
    (select-window w)))
;;; disable tool-bar
(tool-bar-mode -1)
;;; maximize screen at start
(set-frame-parameter nil 'fullscreen 'maximized)

;;dsahboard-------------------------------------------------------
(package-install 'dashboard) ;自動インストール
;; use dashboard at start-up
(require 'dashboard)
;; Set the title
(setq dashboard-banner-logo-title " ")
;; Set the banner
;;(setq dashboard-startup-banner "/home/denjo/.emacs.d/bg/bg.png")
(dashboard-setup-startup-hook)
;-----------------------------------------------------------------

;------------------------
; 2. Color 
;------------------------

;;;Display color
(set-frame-parameter (selected-frame) 'alpha '(90 90))
(set-background-color "Black")
(set-foreground-color "dodger blue")

;;;Hi-Line
 (defface hlline-face
  '((((class color)
      (background dark))
     (:background "gray10"))
    (((class color)
      (background light))
     (:background "OliveDrab1"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
(global-hl-line-mode)

;;; Switch alpha
(setq alpha-on-flag nil)
(defun alpha-toggle()
  (interactive)
  (if (equal alpha-on-flag t)
      (progn
	(set-frame-parameter nil 'alpha 90)
	(setq alpha-on-flag nil)
	(message "alpha-off"))
    (progn
      (set-frame-parameter nil 'alpha 30)
      (setq alpha-on-flag t)
      (message "alpha-on"))))

;;; Set alpha as number
(defun set-alpha (key)
  "set frame parameter 'alpha"
  (interactive "nAlpha: ")
  (set-frame-parameter nil 'alpha (cons key '(90))))


;--------------------------
; 3. editting
;--------------------------

;;; show column-number
(column-number-mode t)
;;; show line-number
(global-linum-mode t)
;;; hi-light ()
(show-paren-mode 1)
;;; select by Shift + ->
(setq pc-select-selection-keys-only t)
;;; 改行コードを表示する。
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-++mnemonic-unix "(LF)")
;;; disable tab for indent
(setq-default indent-tabs-mode nil)
;;; C-k to kill whole line
(setq kill-whole-line t)
;; C-u C-SPC C-SPC ...でどんどん過去のマークを遡る
(setq set-mark-command-repeat-pop t)

;-----------------------
; 4. bars
;-----------------------

;;; show full-path of the file at title bar
(setq frame-title-format "%b %f %& %Z")
;;; show current time
(display-time-mode t)
(setq display-time-24hr-format t)
;;; show current time at modeline
(display-time)
;;; 複数のディレクトリで同じファイル名のファイルを開いたときのバッファ名を調整する
(require 'uniquify)
;; filename<dir> 形式のバッファ名にする
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "[^*]+")

;;powerline------------------------------------------------------
(package-install 'powerline) ;auto installing

(require 'powerline)
(defconst color1 "gray20")
(defconst color2 "SteelBlue4")

(set-face-attribute 'mode-line nil
                    :foreground "#fff"
                    :background color1
                    :bold t
                    :box nil)

(set-face-attribute 'powerline-active1 nil
                    :foreground "white smoke"
                    :background color2
                    :bold t
                    :box nil
                    :inherit 'mode-line)

(set-face-attribute 'powerline-active2 nil
                    :foreground "white smoke"
                    :background "gray20"
                    :bold t
                    :box nil
                    :inherit 'mode-line)

(set-face-attribute 'mode-line-inactive nil
                    :foreground "#fff"
                    :background color1
                    :bold t
                    :box nil)

(set-face-attribute 'powerline-inactive1 nil
                    :foreground "white smoke"
                    :background color2
                    :bold t
                    :box nil
                    :inherit 'mode-line)

(set-face-attribute 'powerline-inactive2 nil
                    :foreground "white smoke"
                    :background "gray20"
                    :bold t
                    :box nil
                    :inherit 'mode-line)

(powerline-center-theme)
;------------------------------------------------

;--------------------------
; 5. keybinds
;-------------------------

(define-key global-map (kbd "C-z") 'undo)
(define-key global-map (kbd "C-w") 'kill-region)
(define-key global-map (kbd "C-+") 'alpha-toggle)
;;backspace
(global-set-key (kbd "C-h") 'delete-backward-char)
;;move window
(define-key global-map (kbd "C-x o") (lambda () (interactive) (other-window -1)))
(define-key global-map (kbd "C-x p") (lambda () (interactive) (other-window 1)))
;--------------------------
; 6. history
;--------------------------

;;; save the position when open the file
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (concat user-emacs-directory "places"))
;;; ミニバッファ履歴を次回Emacs起動時にも保存する
(savehist-mode 1)
;;; 同じ内容を履歴に記録しないようにする
(setq history-delete-duplicates t)
;;; ログの記録行数を増やす
(setq message-log-max 10000)
;;; save history more
(setq history-length 1000)

;-----------------------------
; 7. others
;-----------------------------
;;; 右から左に読む言語に対応させないことで描画高速化
(setq-default bidi-display-reordering nil)
;;; GCを減らして軽くする
(setq gc-cons-threshold (* 10 gc-cons-threshold))
;;; do not make auto-save file
(setq make-backup-files nil)
;;; delet auto-save files at end
(setq delete-auto-save-files t)
;;y-n
(fset 'yes-or-no-p 'y-or-n-p)
