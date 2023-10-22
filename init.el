
(setq
 inhibit-startup-message t ; We do not care about the startup message
 ring-bell-function 'ignore ; The bell is annoying, don't ring that
 )

(delete-selection-mode t) ; Replace selected text with input
(global-set-key [remap list-buffers] #'buffer-menu)

;; Winner Mode is a global minor mode that allows you to "undo" and "redo"
;; changes in WindowConfiguration. It is included in GNU Emacs, and documented
;; as winner-mode.
(when (fboundp 'winner-mode) (winner-mode 1))

(setq
 backup-directory-alist `((".*" . ,"~/Documents/.backups"))
 desktop-dirname (concat "~/.emacs.d/" (system-name))
 desktop-base-file-name      "emacs.desktop"
 desktop-base-lock-name      "lock"
 desktop-path                (list desktop-dirname)
 desktop-save                t
 desktop-files-not-to-save   "^$" ;reload tramp paths
 desktop-load-locked-desktop nil
 desktop-auto-save-timeout   30)

(desktop-save-mode 1)
(global-auto-revert-mode t)

(use-package sudo-edit)
(use-package rg
  :config (setq rg-ignore-case 'smart)
  :init (rg-enable-default-bindings))

(use-package swiper)

(use-package company
  :diminish company-mode
  :bind (("TAB" . 'company-complete))
  :config (global-company-mode))

(setq
 fringe-mode 10
 custom-safe-themes t)

(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

(use-package rainbow-mode
  :config
  (rainbow-mode 1))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package diminish)

(add-hook 'prog-mode-hook (lambda () (display-line-numbers-mode 1)))
(add-hook 'prog-mode-hook (lambda () (set-default 'truncate-lines t)))

(load-theme 'wombat)

;; Be evil >:)
(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  (setq evil-want-keybinding nil
	evil-respect-visual-line-mode t
	evil-want-C-u-scroll t)
  :config
  (evil-set-undo-system 'undo-redo)
  (evil-mode 1))

(use-package evil-collection
  :diminish evil-collection-unimpaired-mode
  :after evil
  :config (evil-collection-init))

(use-package ivy
  :diminish ivy-mode
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(define-key evil-normal-state-map (kbd "/") 'swiper)

;; Descriptive commands within ivy
(use-package ivy-rich
  :after counsel
  :config (ivy-rich-mode 1))

;; Interactive completion functions
(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map evil-normal-state-map
	 ("SPC x" . counsel-M-x)
	 ("SPC SPC" . counsel-ibuffer)
	 ("SPC f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history)))

(use-package which-key
  :diminish which-key-mode
  :init (setq which-key-idle-delay 0.3)
  :config (which-key-mode))

(use-package helpful :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-command] . helpful-command)
  ([remap describe-key] . helpful-key))

;; Set up nix mode
(use-package nix-mode :mode "\\.nix\\'")

;; Python config

(with-eval-after-load 'python
  (define-key python-mode-map (kbd "<tab>") 'python-indent-shift-right)
  (define-key python-mode-map (kbd "S-<tab>") 'python-indent-shift-left))

(use-package flycheck
  :config (global-flycheck-mode))

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-l")
  :hook ((tuareg-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)

(set-face-attribute 'default nil :font "Fira Code" :height 130)
