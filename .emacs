

;;Dane's .emacs config file 
;;January 6, 2013


;;================  Respositories =============================

(require 'package)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                           ("marmalade" . "http://marmalade-repo.org/packages/")
                           ("melpa" . "http://melpa.milkbox.net/packages/")))
						   



;;================= Package Initialization ==================

(package-initialize)



;;==============Load Path===========================

 (add-to-list 'load-path "~/Dane/.emacs.d/elpa")
 (add-to-list 'load-path "~/.emacs.d/el-get")
;; (setq el-get-user-package-directory "~/.emacs.d/packages.d/")

;;==============Autoloads ==========================

 


(add-to-list 'load-path "~/Dane/.emacs.d/elpa/org-20121231")

(add-to-list 'load-path "~/Dane/.emacs.d/elpa/js2-mode-20130120.2003")

(require 'python)
(add-to-list 'load-path "~/Dane/.emacs.d/elpa/python-mode-6.0.10")

(require 'flymake-python-pyflakes)
(add-to-list 'load-path "~/Dane/.emacs.d/elpa/flymake-python-pyflakes-20130512.1844")


(require 'writeroom-mode)
(add-to-list 'load-path "~/Dane/.emacs.d/elpa/writeroom-mode-30315.2007")

(require 'auto-complete)
(add-to-list 'load-path "~/Dane/.emacs.d/elpa/auto-complete-20130503.2013")

(require 'magit)
(add-to-list 'load-path "~/Dane/.emacs.d/elpa/magit-201300524.1906")



;;================== Ruby on Rails Recipe =========================
(setq el-get-sources
      '((:name ruby-mode 
               :type elpa
               :load "ruby-mode.el"
               :after (lambda () (ruby-mode-hook)))
        (:name inf-ruby  :type elpa)
        (:name ruby-compilation :type elpa)
        (:name css-mode 
               :type elpa 
               :after (lambda () (css-mode-hook)))
        (:name textmate
               :type git
               :url "git://github.com/defunkt/textmate.el"
               :load "textmate.el")
        (:name rvm
               :type git
               :url "http://github.com/djwhitt/rvm.el.git"
               :load "rvm.el"
               :compile ("rvm.el")
               :after (lambda() (rvm-use-default)))
        (:name rhtml
               :type git
               :url "https://github.com/eschulte/rhtml.git"
               :features rhtml-mode
               :after (lambda () (rhtml-mode-hook)))
        (:name yaml-mode 
               :type git
               :url "http://github.com/yoshiki/yaml-mode.git"
               :features yaml-mode
               :after (lambda () (yaml-mode-hook)))))


;;===============Ruby Hooks ====================================

(defun ruby-mode-hook ()
  (autoload 'ruby-mode "ruby-mode" nil t)
  (add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
  (add-hook 'ruby-mode-hook '(lambda ()
                               (setq ruby-deep-arglist t)
                               (setq ruby-deep-indent-paren nil)
                               (setq c-tab-always-indent nil)
                               (require 'inf-ruby)
                               (require 'ruby-compilation))))
(defun rhtml-mode-hook ()
  (autoload 'rhtml-mode "rhtml-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . rhtml-mode))
  (add-to-list 'auto-mode-alist '("\\.rjs\\'" . rhtml-mode))
  (add-hook 'rhtml-mode '(lambda ()
                           (define-key rhtml-mode-map (kbd "M-s") 'save-buffer))))
(defun yaml-mode-hook ()
  (autoload 'yaml-mode "yaml-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode)))
(defun css-mode-hook ()
  (autoload 'css-mode "css-mode" nil t)
  (add-hook 'css-mode-hook '(lambda ()
                              (setq css-indent-level 2)
                              (setq css-indent-offset 2))))

(add-hook 'ruby-mode-mode-hook 'auto-complete-mode)

;;=========== Ruby Test Buffer =============================

(defun is-rails-project ()
  (when (textmate-project-root)
    (file-exists-p (expand-file-name "config/environment.rb" (textmate-project-root)))))
(defun run-rails-test-or-ruby-buffer ()
  (interactive)
  (if (is-rails-project)
      (let* ((path (buffer-file-name))
             (filename (file-name-nondirectory path))
             (test-path (expand-file-name "test" (textmate-project-root)))
             (command (list ruby-compilation-executable "-I" test-path path)))
        (pop-to-buffer (ruby-compilation-do filename command)))
    (ruby-compilation-this-buffer)))




;;=============== Org Mode ======================

'(org-completion-use-ido t)
'(org-completion-use-iswitchb t)


;;to capture time stamps and/or notes when TODO state changes, in particular when a task is DONE?
(setq org-log-done 'time)

;;(require 'org-bullets)
;;(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))


(add-hook 'org-mode-hook (lambda () (linum-mode -1)))
(add-hook 'org-mode-hook 'auto-complete-mode)


;;default type for org-mode files
(setq auto-mode-alist (cons '("\\.org$" . org-mode) auto-mode-alist))

(setq org-startup-indented t)



;;(add-to-list 'iimage-mode-image-regex-alist
;;             (cons (concat "\\[\\[file:\\(~?" iimage-mode-image-filename-regex
;;                           "\\)\\]")  1))

(defun org-toggle-iimage-in-org ()
  "display images in your org file"
  (interactive)
  (if (face-underline-p 'org-link)
      (set-face-underline-p 'org-link nil)
      (set-face-underline-p 'org-link t))
  (iimage-mode))



;;=============== el-get ==================================
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

(el-get 'sync)


;; =============Python Mode Stuff==========================





(defun python-mode-hook ()
(add-hook 'python-mode-hook)
;; to make emacs default for python files
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(add-hook 'python-mode-hook '(lambda () (require 'virtualenv)))
(add-hook 'python-mode-hook '(lamdba () (virtualenv-workon "Users/Dane/.emacs.d/elpa/jedi-20130714.1415/env/bin")))
;;(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(autoload 'python-mode  "python-mode" "Python editing mode." t)
(autoload 'doctest-mode 'doctest-mode "Doctest unittest editing mode." t)
(autoload 'jedi:setup "jedi" nil t)
;; Start autocomplete and jedi for refactoring
(add-hook 'python-mode-hook 'auto-complete-mode)
(add-hook 'python-mode-hook 'jedi-mode)
(add-hook 'python-mode-hook 'flycheck-mode)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t))	 

;;===============Virtualenv Path =================


;;(setenv "PATH" (concat (getenv "PATH") ":"  "/Users/Dane/ework/bin"))
;;(add-to-list 'exec-path  "/Users/Dane/ework/bin")
	
	
;;in file /path/to/project/.dir-locals.el:
;;((nil . ((virtualenv-workon . "tg2.1")
;;	 (virtualenv-default-directory . "/path/to/project/subdir"))))
;;============== Scala Mode ========================

(require 'scala-mode2)
(add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode))
(add-to-list 'load-path "~/Dane/.emacs.d/elpa/scala-mode2-20131115.2347")
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(push "/media/data/tools/scala/scala/bin/" exec-path)
(push "/media/data/tools/sbt/" exec-path)


;;'(ensime-inf-cmd-template (quote ("sbt" "console" "-classpath" :classpath)))
 ;; This variable is used to launch the interpreter
;; '(ensime-inf-default-cmd-line (quote ("sbt" "console"))))

;;M-x ensime-sbt

;;This will find the project for the source file you are in and turn on the detection of error-messages automatically.



;;===================== sync path from terminal with Emacs =============================≈x
;;to sync path

;;(defun set-exec-path-from-shell-PATH ()
;;    (let ((path-from-shell (shell-command-to-string "$SHELL -c 'echo $PATH'")))
;;      (setenv "PATH" path-from-shell)
;;      (setq exec-path (split-string path-from-shell path-separator))))
;;(when window-system (set-exec-path-from-shell-PATH))



;;============== Js2-mode ========================

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js2-mode-hook 'ac-js2-mode)

;;You may also want to hook it in for shell scripts running via node.js:
;; (add-to-list 'interpreter-mode-alist '("node" . js2-mode))
;;===============el-get packages =====================

(setq my:el-get-packages
	'(goto-last-change
	  dirtree))


(el-get 'sync my:el-get-packages)

;;============== Last Change =====================

;;last change in a file C-x C-/ 

(setq el-get-sources
   '((:name goto-last-change
               :after(progn
                (global-set-key (kbd "C-x C-/") 'goto-last-change)))))
				
				
				
				
;;=============== dirtree =======================
(setq el-get-sources
 '((:name dirtree
	:load dirtree.el
       :after(progn
		 (global-set-key (kbd "C-x C-t") 'dirtree)))))
				




;;=============Auto Complete Mode =========================

(global-auto-complete-mode +1)
	
;; ===== Set the highlight current line minor mode ===== 

;; In every buffer, the line which contains the cursor will be fully highlighted

(global-hl-line-mode 1)
;;=============Writeroom Mode ==================



(add-hook 'writeroom-mode-hook (lambda () (linum-mode -1)))



;;========== disable audiable bell =============

(setq visible-bell t)


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
;; modes.  The other way to do this is to turn on the fill for specific modes
;; via hooks.

	(setq auto-fill-mode 1)
	
;;========== set default frame ==========

(setq default-frame-alist(split-window-horizontally))


(setq default-frame-alist '((width . 133) (height . 45) (menu-bar-lines . 1) (tool-bar-lines .0)))


(add-hook 'text-mode-hook '(lambda () (flyspell-mode 1)))
;;=============Prevent Start-up Message =============


(setq inhibit-startup-message t)
(setq initial-scratch-message  "Gratitde makes sense of our past brings peace for today and creates a vision for tomorrow  --- Melody Beattie")


;;"For me, great algorithms are the poetry of computation. Just like verse, they can be terse, allusive,dense, and even mysterious. But once unlocked, they cast a brilliant new light on some aspect of computing"
;;                                                                 -- Francis Sullivan

;;============== Word Wrap mode ============


(global-visual-line-mode t )


;;============ Active Region Setting ==========
;;(setq transient-mark-mode 't)


;; Activate font-lock mode (syntax coloring).
(global-font-lock-mode t)

;; No fringe line
;;(set fringe-mode -1)


;;=========Yes and No ======================

;; Typing "yes" or "no" takes too long---use "y" or "n"
;;(fset 'yes-or-no-p 'y-or-n-p)



;;=================ido-mode==========================


(require 'ido)
(ido-mode t)
;;(setq ido-enable-flex-matching t)
;;(setq ido-everywhere t)

;;===============Flycheck ========================


(add-hook 'after-init-hook #'global-flycheck-mode)


;;===========================customize============================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-start t)
 '(custom-enabled-themes (quote (deeper-blue)))
 '(ispell-highlight-p t)
 '(org-bullets-bullet-list (quote ("◉" "○" "✸" "✿")))
 '(org-completion-use-ido t)
 '(org-fontify-whole-heading-line t)
 '(org-pretty-entities t)
 '(org-pretty-entities-include-sub-superscripts t)
 '(org-src-fontify-natively t)
 '(org-use-property-inheritance t)
 '(python-skeleton-autoinsert t)
 '(scroll-bar-mode nil)
 '(virtualenv-root "/Users/Dane/.emacs.d/elpa/jedi-20130714.1415/env/bin"))
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
