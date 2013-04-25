 
;; Dane's .emacs file
;; April 2013


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

(add-to-list 'load-path "~/Dane/.emacs.d/elpa/org-20121231")


(require 'python-mode)
(add-to-list 'load-path "~/Dane/.emacs.d/elpa/python-mode-6.0.10")

(require 'flymake-python-pyflakes)
(add-to-list 'load-path "~/Dane/.emacs.d/elpa/flymake-python-pyflakes-201300224.1931")


(require 'writeroom-mode)
(add-to-list 'load-path "~/Dane/.emacs.d/elpa/writeroom-mode-20130315.2007")

(require 'auto-complete)
(add-to-list 'load-path "~/Dane/.emacs.d/elpa/auto-complete-20130330.1836")

(require 'epc)
(add-to-list 'load-path "~/Dane/.emacs.d/elpa/epc-20130312.2201")


(require 'jedi)
(add-to-list 'load-path "~/Dane/.emacs.d/elpa/jedi-20130318.1248")
(autoload 'jedi:setup "jedi" nil t)

(require 'magit)
(add-to-list 'load-path "~/Dane/.emacs.d/elpa/magit-20130409.500")

;;=============Auto Complete Mode =========================
(define-globalized-minor-mode real-global-auto-complet-mode
   auto-complete-mode (lambda ()
                         ( if (current-buffer)))
                            (auto-complete-mode 1))

(global-auto-complete-mode  1)


;;=============PHP Mode==========================


(require 'php-mode)
(setq auto-mode-alist
  (append '(("\.php$" . php-mode)
            ("\.module$" . php-mode))
              auto-mode-alist))


;;==============Custom File Save======================



;; ===== Set the highlight current line minor mode =====

;; In every buffer, the line which contains the cursor will be fully
;; highlighted

(global-hl-line-mode 1)

;; ========== Enable Line and Column Numbering ==========

;; Show line-number in the mode line
(line-number-mode 1)

;; Show column-number in the mode line
(column-number-mode 1)

;;==============Active Region Setting===================

(transient-mark-mode 1)


;; ===== Turn on Auto Fill mode automatically in all modes =====

;; Auto-fill-mode the the automatic wrapping of lines and insertion of
;; newlines when the cursor goes over the column limit.

;; This should actually turn on auto-fill-mode by default in all major
;; modes. The other way to do this is to turn on the fill for specific modes
;; via hooks.

(setq auto-fill-mode  1)

;;========== set default frame ==========

(setq default-frame-alist(split-window-horizontally))


(setq default-frame-alist '((width . 133) (height . 45) (menu-bar-lines . 1) (tool-bar-lines .0)))

'(split-window-keep-point t)


;;=============Default Mode==============

(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook 'flyspell-mode)


;;============Smooth Scrolling================
(setq scroll-conservatively 1000  scroll-step 1)


;;=============Make Frame================================

(global-set-key "\C-f" 'make-frame)


;;============Color Theme===================================

;;=============dabbrev-expand=============================

;;Type the first few characters, then type M-/ (dabbrev-expand), which expands the previous word by looking for the most recent ;;word that matches. If nothing is found in the current buffer before point, it looks after point. If it's not found in the current ;;buffer, then other buffers are searched until it is found.

;;If the wrong word is found, type M-/ again and it will look for another word that matches the characters you typed, replacing its ;;first guess with another. Lather, rinse, repeat.

;;(setq dabbrev-case-replace nil)



;;================Magit=========================================


(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green3")
     (set-face-foreground 'magit-diff-del "red3")
     (set-face-background 'magit-item-highlight "black")))


;;===========WriteGood Mode ================================
;; Supply the path to the mode repository
(add-to-list 'load-path "~/Dane/.emacs.d/elpa/writegood-mode")
(require 'writegood-mode)
;; Set a global key to toggle the mode
(global-set-key "\C-cg" 'writegood-mode)


;;============  Writeroom ============================




;;==========Org Mode ==============

;;select, do [M-x eval-region]. The *s will be replaced with utf-8 bullets next time you open an org file

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))


(add-hook 'mail-mode-hook 'turn-on-orgtbl)
(add-hook 'mail-mode-hook 'turn-on-orgstruct)
(add-hook 'org-mode-hook 'turn-on-font-lock)

;; Add an effort estimate on the fly when clocking in" on the Org Hacks page:

(add-hook 'org-clock-in-prepare-hook
          'my-org-mode-ask-effort)

(add-hook 'outline-minor-mode-hook
  (lambda ()
    (define-key outline-minor-mode-map [(control tab)] 'org-cycle)
    (define-key outline-minor-mode-map [(shift tab)] 'org-global-cycle)))
(add-hook 'outline-mode-hook
  (lambda ()
    (define-key outline-mode-map [(tab)] 'org-cycle)
    (define-key outline-mode-map [(shift tab)] 'org-global-cycle)))

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

;;Track time in Org Mode

(setq org-clock-idle-time nil) 
     (setq org-log-done 'time)
     (defadvice org-clock-in (after wicked activate)
  "Mark STARTED when clocked in"
  (save-excursion
    (catch 'exit
      (org-back-to-heading t)
      (if (looking-at org-outline-regexp) (goto-char (1- (match-end 0))))
      (if (looking-at (concat " +" org-todo-regexp "\\( +\\|[ \t]*$\\)"))
	  (org-todo "STARTED")))))

(setq org-clock-idle-time nil)

 
:; Fontify org-mode
(setq org-src-fontiy-natively t)

;; link formation [[link][description]]

;;======== TODO Functions ==================

(defun org-summary-todo (n-done n-not-done)
"Switch entry to DONE when all subentries are done, to TODO otherwise."
(let (org-log-done org-log-states) ; turn off logging
(org-todo (if (= n-not-done 0) "DONE" "TODO"))))
;;=========Yes and No ======================

; Typing "yes" or "no" takes too long---use "y" or "n"
(fset 'yes-or-no-p 'y-or-n-p)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-modes (quote (emacs-lisp-mode lisp-mode lisp-interaction-mode slime-repl-mode c-mode cc-mode c++-mode go-mode java-mode malabar-mode clojure-mode clojurescript-mode scala-mode scheme-mode ocaml-mode tuareg-mode coq-mode haskell-mode agda-mode agda2-mode perl-mode cperl-mode python-mode ruby-mode lua-mode ecmascript-mode javascript-mode js-mode js2-mode php-mode css-mode makefile-mode sh-mode fortran-mode f90-mode ada-mode xml-mode sgml-mode ts-mode sclang-mode verilog-mode org-mode writeroom-mode)))
 '(ansi-term-color-vector [unspecified "#FFFFFF" "#d15120" "#5f9411" "#d2ad00" "#6b82a7" "#a66bab" "#6b82a7" "#505050"])
 '(buffer-offer-save nil)
 '(color-theme-legal-frame-parameters "\\(color\\|mode\\|font\\|height\\|width\\)$")
 '(color-theme-load-all-themes t)
 '(color-theme-mode-hook t)
 '(column-number-mode t)
 '(completion-auto-help t)
 '(completions-format (quote vertical))
 '(custom-enabled-themes (quote (deeper-blue)))
 '(custom-safe-themes (quote ("e0c6e4273bbb272e090a60a834310669490a41f67b9f8206aa7a140661cf7e5b" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "fca8ce385e5424064320d2790297f735ecfde494674193b061b9ac371526d059" "78b1c94c1298bbe80ae7f49286e720be25665dca4b89aea16c60dacccfbb0bca" default)))
 '(custom-theme-load-path (quote ("/Users/Dane/.emacs.d/elpa/solarized-theme-20120921.1634/" "/Users/Dane/.emacs.d/elpa/twilight-bright-theme-20120630.2245/" "/Users/Dane/.emacs.d/elpa/zenburn-theme-20120915.1256/" "/Users/Dane/.emacs.d/elpa/color-theme-2008035.834" "/Users/Dane/.emacs.d/elpa/zen-theme-20121004.2308" "/Users/Dane/.emacs.d/elpa/tron-theme-12" t)))
 '(focus-follows-mouse t)
 '(fringe-mode 0 nil (fringe))
 '(global-hi-lock-mode t)
 '(global-highlight-changes-mode t)
 '(highlight-changes-colors (quote ("yellow" "Green" "Cyan" "Magenta" "lightBlue" "green4" "DarkOrchid")))
 '(ido-enable-flex-matching t)
 '(ido-mode (quote both) nil (ido))
 '(make-backup-files nil)
 '(org-completion-use-ido t)
 '(org-completion-use-iswitchb t)
 '(ps-use-face-background nil)
 '(python-mode-hook (quote (abbrev-mode jedi:ac-setup flymake-python-pyflakes-load (lambda nil (when py-smart-indentation (if (bobp) (save-excursion (save-restriction (widen) (while (and (not (eobp)) (or (let ((erg (syntax-ppss))) (or (nth 1 erg) (nth 8 erg))) (eq 0 (current-indentation)))) (forward-line 1)) (back-to-indentation) (py-guess-indent-offset))) (py-guess-indent-offset)))) (lambda nil (setq indent-tabs-mode py-indent-tabs-mode) (set (make-local-variable (quote beginning-of-defun-function)) (quote py-beginning-of-def-or-class)) (set (make-local-variable (quote end-of-defun-function)) (quote py-end-of-def-or-class))))))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(split-window-keep-point t)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(version-control t)
 '(word-wrap t))

(put 'downcase-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-doc-face ((t (:inherit font-lock-string-face))))
 '(highlight-changes ((t (:foreground "Orange"))))
 '(ido-first-match ((t (:foreground "Yellow" :weight normal))))
 '(info-menu-star ((t (:foreground "Green"))))
 '(org-level-2 ((t (:foreground "Green"))))
 '(org-level-3 ((t (:foreground "Yellow"))))
 '(trailing-whitespace ((t (:background "Grey")))))



 (defun djcb-opacity-modify (&optional dec)
  "modify the transparency of the emacs frame; if DEC is t,
    decrease the transparency, otherwise increase it in 10%-steps"
  (let* ((alpha-or-nil (frame-parameter nil 'alpha)) ; nil before setting
          (oldalpha (if alpha-or-nil alpha-or-nil 100))
          (newalpha (if dec (- oldalpha 10) (+ oldalpha 10))))
    (when (and (>= newalpha frame-alpha-lower-limit) (<= newalpha 100))
      (modify-frame-parameters nil (list (cons 'alpha newalpha))))))

 ;; C-8 will increase opacity (== decrease transparency)
 ;; C-9 will decrease opacity (== increase transparency
 ;; C-0 will returns the state to normal
(global-set-key (kbd "C-8") '(lambda()(interactive)(djcb-opacity-modify)))
(global-set-key (kbd "C-9") '(lambda()(interactive)(djcb-opacity-modify t)))
(global-set-key (kbd "C-0") '(lambda()(interactive)
                               (modify-frame-parameters nil `((alpha . 100)))))


(put 'upcase-region 'disabled nil)


;; ===========turn on Common Lisp support==============
(require 'cl)  ; provides useful things like `loop' and `setf'

;; ========save the editor state================

  (desktop-save-mode -1)






;; =============Python Mode Stuff===================================

(epy-setup-checker "pyflakes %f")
(require 'flymake-python-pyflakes) 
(add-hook 'python-mode-hook-pyflakes-load '%f)

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
 
 (add-to-list 'flymake-allowed-file-name-masks
 '("\\.py\\'" flymake-pyflakes-init)))
 
(add-hook 'find-file-hook 'flymake-find-file-hook)



(autoload 'python-mode "python-mode" "Python editing mode." t)


(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;; always use spaces not tabs when indenting
;;(setq indent-tabs-mode nil)

;; ignore case when searching
(setq case-fold-search t)

(setq py-load-pymacs-p t)
(setq py-complete-set-keymap-p t)
(setq python-check-command "pyflakes")



;;==========Jedi Function From ==============
;; http://tkf.github.com/emacs-jedi/

;; (require 'jedi)
;; (add-hook 'python-mode-hook 'jedi:ac-setup)

;;'("python" "JEDI:/Users/Dane/.emacs.d/elpa/jedi-20120223.4/jediepcserver.py")






;;=======Following Function from ====================
;;   https://github.com/kiwanami/emacs-epc


(require 'epcs)

(let ((connect-function
     (lambda (mngr)
         (epc:define-method mngr 'echo (lambda (&rest x) x) "args" "just echo back arguments.")
         (epc:define-method mngr 'add '+ "args" "add argument numbers.")
         )) server-process)

  (setq server-process (epcs:server-start connect-function))
  (sleep-for 10)
   (epcs:server-stop server-process))


;;======== epc additional info ===============
;;https://python-epc.readthedocs.org/en/latest/#epc.server.EPCServer.register_function

;;=====================================================================================
;;=====================================================================================

;;=========No Auto Save====================

(setq auto-save-list-filen-name nil) ;no .save files
(setq auto-save-default nil) ;no auto saving






