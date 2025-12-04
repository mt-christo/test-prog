(cua-mode t)
(setq-default indent-tabs-mode nil)

;(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(require 'package) ;; You might already have this line
(require 'use-package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
;(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
;  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
;(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
;(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))
(add-to-list 'process-coding-system-alist '("python" . (utf-8 . utf-8)))
(package-initialize)

(require 'aidermacs)
(require 'aider)
(use-package aidermacs
:config
  ; Set API_KEY in .bashrc, that will automatically picked up by aider or in elisp
  (setenv "ANTHROPIC_API_KEY" "")
  ; defun my-get-openrouter-api-key yourself elsewhere for security reasons
  (setenv "OPENROUTER_API_KEY" "")
  :custom
  ; See the Configuration section below
  (aidermacs-use-architect-mode t)
  (aidermacs-default-model "sonnet")
  (aidermacs-architect-model "anthropic/claude-opus-4-5-20251101")
  (aidermacs-editor-model "anthropic/claude-sonnet-4-5-20250929"))

(use-package company
  :ensure t
  :hook (after-init . global-company-mode))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package lsp-mode
  :hook ((python-mode . lsp)
         (ess-r-mode . lsp))
  :commands lsp
  :config
  (setq lsp-keymap-prefix "C-c l"))  ;; optional keymap prefix

(use-package lsp-ui
  :commands lsp-ui-mode)

(use-package company
  :hook (after-init . global-company-mode))


(add-hook 'python-mode-hook #'lsp)
(add-hook 'ess-r-mode-hook #'lsp)

(elpy-enable)
;;(set-default 'truncate-lines t)
(define-key input-decode-map "\e[4~" 'end-of-line)
(global-set-key (kbd "C-w")  'treemacs)
(global-set-key (kbd "M-o m")  (kbd "RET"))
(global-set-key (kbd "<f5>")  'python-shell-send-region)
(global-set-key (kbd "C-q")  'ess-eval-region-or-line-and-step)
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)
(global-set-key (kbd "C-c p") 'run-python)
(global-set-key (kbd "C-a") 'aidermacs-transient-menu)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
 '(custom-enabled-themes '(adwaita))
 '(elpy-rpc-backend "rope")
 '(elpy-rpc-python-command "python3")
 '(gptel-api-key
   "")
 '(package-selected-packages
   '(treemacs use-package aider gnu-elpa-keyring-update aidermacs gptel magit dash editorconfig))
 '(python-shell-interpreter "python3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;(add-to-list 'load-path "/wrk/ess")
;;(load "ess-site")

(require 'ess-site)
;(ess-toggle-underscore nil)
;;(require 'editorconfig)
;;(editorconfig-mode 1)

(add-to-list 'load-path "/home/ubuntu/src/copilot/")
(require 'copilot)
(add-hook 'prog-mode-hook 'copilot-mode)
(define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
(define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)


;(require 'pc-select)
;(global-set-key (kbd "S-<prior>") 'scroll-down-mark)
;(global-set-key (kbd "S-<next>") 'scroll-up-mark)
;(setq shift-select-mode t)

(defun run-hardcoded-shell-command-and-return ()
  "Run a hardcoded shell command in a dedicated shell frame and return to the previous frame."
  (interactive)
  (let ((original-window (selected-window)) ;; Save the current window
        (buffer-name "*My Shell Command Output*")
        (command "cd ~/src/2test; bin/slepnev_run_test.sh tests/investments/test_03_portfolio_models.py")) ;; Replace with your desired command
    ;; Create or switch to the shell buffer
    (if (get-buffer buffer-name)
        (progn
          (select-window (display-buffer buffer-name)))
      (progn
        (split-window-below) ;; Create a new shell frame
        (other-window 1)     ;; Move to the new window
        (shell buffer-name))) ;; Open a shell in the new window
    ;; Insert and execute the command
    (goto-char (point-max))
    (insert command)
    (comint-send-input)
    ;; Return to the original window
    (select-window original-window)))

;; Bind the function to Ctrl-t
;(global-set-key (kbd "C-t") 'run-hardcoded-shell-command-and-return)

;; Close buffer
(global-set-key (kbd "M-0") 'kill-this-buffer)
