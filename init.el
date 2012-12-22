(require 'package)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)
 
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.text" . markdown-mode) auto-mode-alist)) 
 
;; ===== Automatically load abbreviations table =====
 
;; Note that emacs chooses, by default, the filename
;; "~/.abbrev_defs", so don't try to be too clever
;; by changing its name
 
 
;; ===== Set the highlight current line minor mode =====
 
;; In every buffer, the line which contains the cursor will be fully
;; highlighted
 
(global-hl-line-mode 1)
 
;; ===== Set standard indent to 2 rather that 4 ====
(setq standard-indent 4)
 
;; ========== Line by line scrolling ==========
 
;; This makes the buffer scroll by only a single line when the up or
;; down cursor keys push the cursor (tool-bar-mode) outside the
;; buffer. The standard emacs behaviour is to reposition the cursor in

;; the center of the screen, but this can make the scrolling confusing
 
(setq scroll-step 1)
 
;; ===== Turn off tab character =====
 
;;
;; Emacs normally uses both tabs and spaces to indent lines. If you
;; prefer, all indentation can be made from spaces only. To request this,
;; set `indent-tabs-mode' to `nil'. This is a per-buffer variable;
;; altering the variable affects only the current buffer, but it can be
;; disabled for all buffers.
 
;;
;; Use (setq ...) to set value locally to a buffer
;; Use (setq-default ...) to set value globally
;;
(setq-default indent-tabs-mode nil)
 
;; ========== Support Wheel Mouse Scrolling ==========
 
(mouse-wheel-mode t)
;; ========== Prevent Emacs from making backup files ==========
 
(setq make-backup-files nil)
 
 
;; ========== Place Backup Files in Specific Directory ==========
 
;; Enable backup files.
(setq make-backup-files t)
 
;; Enable versioning with default values (keep five last versions, I think!)
(setq version-control t)
 
;; Save all backup file in this directory.
(setq backup-directory-alist (quote ((".*" . "~/.emacs_backups/"))))
 
;; ========== Enable Line and Column Numbering ==========
 
;; Show line-number in the mode line
(line-number-mode 1)
(linum-mode 1)
;; Show column-number in the mode line
(column-number-mode 1)
 
;; ========== Set the fill column ==========
 
;; Enable backup files.
(setq-default fill-column 76)
 
;; ===== Turn on Auto Fill mode automatically in all modes =====
 
;; Auto-fill-mode the the automatic wrapping of lines and insertion of
;; newlines when the cursor goes over the column limit.
 
;; This should actually turn on auto-fill-mode by default in all major
;; modes. The other way to do this is to turn on the fill for specific modes
;; via hooks.
 
(setq auto-fill-mode 1)
 
;; ===== Make Text mode the default mode for new buffers =====
 
(setq default-major-mode 'text-mode)
 
;; ========= Set colours ==========
 
;; Set cursor and mouse-pointer colours
(set-cursor-color "red")
(set-mouse-color "goldenrod")
 
;; Set region background colour
(set-face-background 'region "blue")
 
;; Set emacs background colour
(set-background-color "black")
(set-foreground-color "white")
 
;; ===== Function to delete a line =====
 
;; First define a variable which will store the previous column position
(defvar previous-column nil "Save the column position")
 
;; Define the nuke-line function. The line is killed, then the newline
;; character is deleted. The column which the cursor was positioned at is then
;; restored. Because the kill-line function is used, the contents deleted can
;; be later restored by usibackward-delete-char-untabifyng the yank commands.
(defun nuke-line()
  "Kill an entire line, including the trailing newline character"
  (interactive)
 
  ;; Store the current column position, so it can later be restored for a more
  ;; natural feel to the deletion
  (setq previous-column (current-column))
 
  ;; Now move to the end of the current line
  (end-of-line)
 
  ;; Test the length of the line. If it is 0, there is no need for a
  ;; kill-line. All that happens in this case is that the new-line character
  ;; is deleted.
  (if (= (current-column) 0)
    (delete-char 1)
 
    ;; This is the 'else' clause. The current line being deleted is not zero
    ;; in length. First remove the line by moving to its start and then
    ;; killing, followed by deletion of the newline character, and then
    ;; finally restoration of the column position.
    (progn
      (beginning-of-line)
      (kill-line)
      (delete-char 1)
      (move-to-column previous-column))))
 
;; Now bind the delete line function to the F8 key
(global-set-key [f8] 'nuke-line)
 
 
;(set-default-font "-adobe-courier-medium-r-normal--18-180-75-75-m-110-iso8859-1")
;(set-default-font "-*-lucidatypewriter-medium-*-*-*-12-*-*-*-*-*-*-*")
(set-default-font "Ubuntu Mono-14")
;(set-default-font "lucida console-14")
 
(tool-bar-mode -1)
 
(setq cua-enable-cua-keys nil)           ;; only for rectangles
(cua-mode t)
 
(setq fringe-mode '(1 . 0))              ;; emacs 22+
(delete-selection-mode 1)                ;; delete the sel with a keyp
 
(setq search-highlight t                 ;; highlight when searching...
  query-replace-highlight t)             ;; ...and replacing
(fset 'yes-or-no-p 'y-or-n-p)            ;; enable y/n answers to yes/no
 
(setq initial-scratch-message
  ";; Code Joy -- Byron Welcome!!!\n")
 
;; key board / input method settings
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")       ; prefer utf-8 for language settings
(set-input-method nil)                   ; no funky input for normal editing;
(setq read-quoted-char-radix 10)         ; use decimal, not octal
 
(line-number-mode t)                     ;; show line numbers
(column-number-mode t)                   ;; show column numbers
(size-indication-mode t)                 ;; show file size (emacs 22+)
 
(if (require 'sml-modeline nil 'noerror)    ;; use sml-modeline if available
  (progn
    (sml-modeline-mode 1)                   ;; show buffer pos in the mode line
    (scroll-bar-mode -1))                   ;; turn off the scrollbar
  (scroll-bar-mode 1)                       ;; otherwise, show a scrollbar...
  (set-scroll-bar-mode 'right))             ;; ... on the right
 
(setq
  enable-recursive-minibuffers nil         ;;  allow mb cmds in the mb
  max-mini-window-height .25             ;;  max 2 lines
  minibuffer-scroll-window nil
  resize-mini-windows nil)
 
(icomplete-mode t)                       ;; completion in minibuffer
(setq
  icomplete-prospects-height 1           ;; don't spam my minibuffer
  icomplete-compute-delay 0)             ;; don't wait
(require 'icomplete+ nil 'noerror)       ;; drew adams' extras
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yasnippet mode
(when (require 'yasnippet nil 'noerror) ;; not: yasnippet-bundle
  (setq yas/root-directory
    '("~/.emacs.d/yas/yasnippet/snippets"
       "~/.emacs.d/yas/custom")) ;; my own snippets
  (mapc 'yas/load-directory yas/root-directory)
  (setq yas/wrap-around-region t)
  (setq yas/prompt-functions
    '(yas/x-prompt yas/ido-prompt))
  (yas/global-mode 1) ;;  make it global
  (add-to-list 'auto-mode-alist '("yas/.*" . snippet-mode)))
 
(add-to-list 'load-path "~/.emacs.d/packages")
(require 'yasnippet-bundle)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; global keybindings
;;
(global-set-key (kbd "RET")         'newline-and-indent)
(global-set-key (kbd "C-<f4>")      'kill-buffer-and-window)
(global-set-key (kbd "<delete>")    'delete-char)  ; delete == delete   
(global-set-key (kbd "M-g")         'goto-line)    ; M-g  'goto-line
 
(when (fboundp 'ibuffer)
  (global-set-key (kbd "C-x C-b") 'ibuffer))   ;; ibuffer
 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; programming
(autoload 'linum-mode "linum" "mode for line numbers" t)
(global-set-key (kbd "C-<f5>") 'linum-mode)                 ;; line numbers
(global-set-key (kbd "C-<f6>") 'magit-status)               ;; ...git mode
(global-set-key (kbd "C-<f7>") 'compile)                     ;; compile
(global-set-key (kbd "C-<f8>") 'comment-or-uncomment-region) ;; (un)comment
 
(when (fboundp 'sr-speedbar-toggle)
  (global-set-key (kbd "C-<f9>") 'sr-speedbar-toggle)
  (global-set-key (kbd "C-<f10>") 'sr-speedbar-select-window)) ; speedbar
(global-set-key (kbd "C-c d") 'djcb-dup)
