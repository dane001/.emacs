;;Dane's .emacs config file 
;;May 27, 2013


;;================  Respositories =============================

(require 'package)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                           ("marmalade" . "http://marmalade-repo.org/packages/")
                           ("melpa" . "http://melpa.milkbox.net/packages/")))

;;================= Package Initialization ==================

(package-initialize)

;;==============Load Path===========================

 (add-to-list 'load-path "~/Dane/.emacs.d/elpa")

;;==============Autoloads ==========================

   (autoload 'ruby-mode "ruby-mode" "Major mode for ruby files" t)
   (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
   (add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))



(add-to-list 'load-path "~/Dane/.emacs.d/elpa/org-20121231")

;;(require 'pyflakes-1.0)
;;(add-to-list 'load-path "~/Dane/.emacs.d/elpa/pyflakes-1.0")

(require 'python-mode)
(add-to-list 'load-path "~/Dane/.emacs.d/elpa/python-mode-6.0.10")

(require 'flymake-python-pyflakes)
(add-to-list 'load-path "~/Dane/.emacs.d/elpa/flymake-python-pyflakes-20130512.1844")


(require 'writeroom-mode)
(add-to-list 'load-path "~/Dane/.emacs.d/elpa/writeroom-mode-30315.2007")

(require 'auto-complete)
(add-to-list 'load-path "~/Dane/.emacs.d/elpa/auto-complete-20130503.2013")

(require 'magit)
(add-to-list 'load-path "~/Dane/.emacs.d/elpa/magit-201300524.1906")

(require 'pyvirtualenv)
(add-to-list 'load-path "~/Dane/.emacs.d/elpa/pyvirtualenv")

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))
(el-get 'sync)

;;=============Auto Complete Mode =========================

(global-auto-complete-mode +1)



;;==============C Mode =========================

(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)


;;=============Java Mode ========================


(eval-after-load 'autoinsert
  '(define-auto-insert '("\\.java\\'" . "Java skeleton")
     '(
       "Short description: "
       "/**\n * "
       (file-name-nondirectory (buffer-file-name))
       " -- " str \n
       " *" \n
       " * Written on " (format-time-string "%A, %e %B %Y.") \n
       " */" > \n \n
      
       (file-name-sans-extension
        (file-name-nondirectory (buffer-file-name)))
       ".h\"" \n \n
       "public static void main(String[] args)" "{" > \n
       > _ \n
       "}" > \n)))








;;=============PHP Mode==========================


(require 'php-mode)
(setq auto-mode-alist
  (append '(("\.php$" . php-mode)
            ("\.module$" . php-mode))
              auto-mode-alist))


;; ===== Set the highlight current line minor mode ===== 

;; In every buffer, the line which contains the cursor will be fully highlighted

(global-hl-line-mode 1)
;;=============Writeroom Mode ==================



(add-hook 'writeroom-mode-hook (lambda () (linum-mode -1)))






;;==============Colort Terminal text======================



(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; ========== Line by line scrolling ========== 

;; This makes the buffer scroll by only a single line when the up or
;; down cursor keys push the cursor (tool-bar-mode) outside the
;; buffer. The standard emacs behaviour is to reposition the cursor in
;; the center of the screen, but this can make the scrolling confusing

(setq scroll-step 1)

;;===============Electric Pair Mode===============

(electric-pair-mode +1)


;;================= Show Matching Parentheeses ================

(show-paren-mode 1)

;; ========== Enable Line and Column Numbering ==========

;; Show line-number in the mode line
;;(line-number-mode 1)

;; Show column-number in the mode line
(column-number-mode 1)

;; Show column-number on left side of buffer
(global-linum-mode +1)



;; ========== Prevent Emacs from making backup files ==========

(setq make-backup-files .0) 

;;Don't want any .save files
(setq auto-save-list-file-name  .0)

;;Don't want auto saving
;;(setq auto-save-default   -1)

;; ===== Turn on Auto Fill mode automatically in all modes =====

;; Auto-fill-mode the the automatic wrapping of lines and insertion of
;; newlines when the cursor goes over the column limit.

;; This should actually turn on auto-fill-mode by default in all major
;; modes. The other way to do this is to turn on the fill for specific modes
;; via hooks.

(setq auto-fill-mode 1)

;;========== set default frame ==========

(setq default-frame-alist(split-window-horizontally))


(setq default-frame-alist '((width . 133) (height . 45) (menu-bar-lines . 1) (tool-bar-lines .0)))



;;=============Prevent Start-up Message =============


(setq inhibit-startup-message t)
(setq initial-scratch-message  "Gratitde makes sense of our past brings peace for today and creates a vision for tomorrow  --- Melody Beattie")

:;============== Word Wrap mode ============


(global-visual-line-mode t )


;;============ Active Region Setting ==========
;;(setq transient-mark-mode 't)


;; Activate font-lock mode (syntax coloring).
(global-font-lock-mode t)

;; No fringe line
;;(set fringe-mode -1)


;;=========Yes and No ======================

;; Typing "yes" or "no" takes too long---use "y" or "n"
(fset 'yes-or-no-p 'y-or-n-p)



;;=================ido-mode==========================


(require 'ido)
(ido-mode t)

;;===============Flycheck ========================


(add-hook 'after-init-hook #'global-flycheck-mode)

;; =============Python Mode Stuff==========================

;;(epy-setup-checker "pyflakes %f")
;;(require 'flymake-python-pyflakes) 
;;(add-hook 'python-mode-hook-pyflakes-load '%f)

;;===== PyFlakes============================
;; code checking via pyflakes+flymake


;;(when (load "flymake" t)
;; (defun flymake-pyflakes-init ()
;; (let* ((temp-file (flymake-init-create-temp-buffer-copy
;; 'flymake-create-temp-inplace))
;; (local-file (file-relative-name
;; temp-file
;; (file-name-directory buffer-file-name))))
;; (list "pyflakes" (list local-file))))
 
;; (add-to-list 'flymake-allowed-file-name-masks
 ;;("\\.py\\'" flymake-pyflakes-init))
 
;;≈(add-hook 'find-file-hook 'flymake-find-file-hook)

(require 'python-mode)
  (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

(autoload 'python-mode "python-mode" "Python editing mode." t)



(setq font-lock-maximum-decoration t)

;; always use spaces not tabs when indenting
(setq indent-tabs-mode nil)

;; ignore case when searching
(setq case-fold-search t)

(setq py-load-pymacs-p t)
(setq py-complete-set-keymap-p t)
(setq python-check-command "pyflakes")
(add-hook 'python-mode-hook 'auto-complete-mode)
(autoload 'jedi:setup "jedi" nil t)


;;=============== Org Mode ======================

 '(org-completion-use-ido t)
 '(org-completion-use-iswitchb t)


;;to capture time stamps and/or notes when TODO state changes, in particular when a task is DONE?
(setq org-log-done 'time)

;;(require 'org-bullets)
;;(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))


(add-hook 'org-mode-hook (lambda () (linum-mode -1)))


;; default type for org-mode files
(setq auto-mode-alist (cons '("\\.org$" . org-mode) auto-mode-alist))

(setq org-startup-indented t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-start t)
 '(custom-enabled-themes (quote (deeper-blue)))
 '(org-bullets-bullet-list (quote ("◉" "○" "✸" "✿")))
 '(org-completion-use-ido t)
 '(org-fontify-whole-heading-line t)
 '(org-pretty-entities t)
 '(org-pretty-entities-include-sub-superscripts t)
 '(org-src-fontify-natively t)
 '(org-use-property-inheritance t)
 '(scroll-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#181a26" :foreground "dark gray" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "apple" :family "Monaco"))))
 '(org-level-1 ((t (:foreground "DeepSkyBlue2"))))
 '(org-level-2 ((t (:inherit outline-2 :foreground "SpringGreen3"))))
 '(org-level-3 ((t (:inherit outline-3 :foreground "yellow"))))
 '(org-level-4 ((t (:inherit outline-4 :foreground "dark cyan")))))


