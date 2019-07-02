(global-set-key "\C-cfgX" 'fgoal-choose-current-workspace)
(global-set-key "\C-cfgr" 'fgoal-run-mas2g)
(global-set-key "\C-cfgff" 'fgoal-load-current-mas2g)

(setq fgoal-current-data-dir "/var/lib/myfrdcsa/codebases/minor/fgoal/data-git")
(setq fgoal-current-workspace "workspace")
(setq fgoal-current-mas "HelloWorld")
(setq fgoal-current-mas2g "HelloWorld10x")

(defun fgoal-choose-current-mas2g ()
 ""
 (interactive)
 (let ((mas2g-file
	(completing-read "mas2g file: "
	 (kmax-grep-list-regexp
	  (kmax-directory-files-no-hidden (frdcsa-el-concat-dir (list fgoal-current-data-dir fgoal-current-workspace fgoal-current-mas)))
	  "\.mas2g.pl$")
	 nil nil fgoal-current-mas2g)))
  (string-match "\\(.*\\).mas2g.pl$" mas2g-file)
  (setq fgoal-current-mas2g (or (match-string 1 mas2g-file) mas2g-file))))

(defun fgoal-choose-current-mas ()
 ""
 (interactive)
 (let ((mas-directory
	(completing-read "MAS directory: "
	 (kmax-directory-files-no-hidden (frdcsa-el-concat-dir (list fgoal-current-data-dir fgoal-current-workspace)))
	 nil nil fgoal-current-mas)))
  (setq fgoal-current-mas mas-directory)
  (fgoal-choose-current-mas2g)))

(defun fgoal-choose-current-workspace ()
 ""
 (interactive)
 (let ((workspace-directory
	(completing-read "Workspace directory: "
	 (kmax-directory-files-no-hidden (frdcsa-el-concat-dir (list fgoal-current-data-dir)))
	 nil nil fgoal-current-workspace)))
  (setq fgoal-current-workspace workspace-directory)
  (fgoal-choose-current-mas)))

(defun fgoal-run-mas2g ()
 ""
 (interactive)
 (shell-command "rm /home/andrewdo/FGOAL/transporter_0.csv; touch /home/andrewdo/FGOAL/transporter_0.csv")
 (run-in-shell
  (concat "swipl -s "
   (shell-quote-argument (fgoal-current-mas2g-path)))
  (concat "*" fgoal-current-mas2g "*")))

(defun fgoal-current-mas2g-path ()
 ""
 (interactive)
 (concat
  (frdcsa-el-concat-dir
   (list fgoal-current-data-dir fgoal-current-workspace fgoal-current-mas fgoal-current-mas2g))
  ".mas2g.pl"))

(defun fgoal-load-current-mas2g ()
 ""
 (interactive)
 (ffap (fgoal-current-mas2g-path)))

(add-to-list 'load-path "/var/lib/myfrdcsa/codebases/minor/fgoal/frdcsa/emacs")

;; (require 'fgoal-frdcsa-mode)
;; (require 'fgoal-mas2g-mode)
;; (require 'fgoal-mod2g-mode)
;; (require 'fgoal-act2g-mode)
