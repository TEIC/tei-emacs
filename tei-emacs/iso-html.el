;;; iso-html.el --- Translating HTML to ISO-8859/1 while editing a file
;;*****************************************************************************
;; $Id: iso-html.el,v 1.1.1.1 2004/09/23 13:23:11 rahtz Exp $
;;*****************************************************************************
;;
;; Description:
;;	When using HTML it is highly desirable to display national
;;	characters contained in the ISO-8859/1 character set. Editing
;;	files with ISO-8859/1 characters is enabled in GNU Emacs since
;;	version 19.
;;
;;	The solution is iso-html.el. The extended
;;	character set is used only temporarily during editing of a
;;	file in Emacs. The HTML file  contains pure ASCII
;;	representations of the extended characters.
;;
;;	iso-html.el provides a minor mode which anchors itself in
;;	various hooks to perform translations when reading or writing
;;	files.
;;
;;	No provisions are made to insert ISO-8859/1 characters since
;;	other packages are availlable for this purpose.
;;
;;
;; Installation:
;;	1. Ensure that iso-html.el is on the load-path.
;;	2. For efficiency it might be desirable to byte-compile 
;;	   iso-html.el.
;;	3. Put the following in your .emacs file or a similar place
;;	   where it is loaded when needed.
;;
;;	   (autoload 'iso-html-minor-mode
;;		     "iso-html"
;;		     "Translate HTML to ISO 8859/1 while visiting a file."
;;		     t)
;;
;;	4. Enable the iso-html minor mode for the appropriate
;;	   files. This depends on the major mode you use for editing
;;	   HTML files. For this purpose you can use the entry hook
;;	   of this mode. E.g.
;;
;;	   (setq html-mode-hook 
;;		 (function (lambda () (interactive)
;;			     (iso-html-minor-mode 1)
;;				; and other initializations
;;				; ...
;;			     )))
;;
;; Bugs and Problems:
;;
;;	- There might be problems when saving a narrowed buffer.
;;	- Point might not be restored properly.
;;
;;	- Writing of a region is not supported. There seems to be no
;;	  appropriate hook.
;;
;;
;; To do:
;;	- iso-html can be used for a wider range of translations when
;;	  reading and writing. Maybe it's worth extracting those
;;	  routines which are more general and make iso-html a sample
;;	  instance of the general routines.
;;
;;
;; Changes:
;;	- Extracted from iso-tex.el
;;
;; Author:	
;;	Gerd Neugebauer
;;	�denburger Str. 16
;;	64295 Darmstadt (Germany)
;;
;;	Net: gerd@imn.th-leipzig.de
;;
;;*****************************************************************************
;; LCD Archive Entry:
;; iso-html|Gerd Neugebauer|gerd@imn.th-leipzig.de|
;; Translating HTML to ISO-8859/1 while editing a file.|
;; $Date: 2004/09/23 13:23:11 $|$Revision: 1.1.1.1 $||
;;*****************************************************************************
;;
;; Copyright (C) 1994 Gerd Neugebauer
;;
;; iso-html.el is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY.  No author or distributor
;; accepts responsibility to anyone for the consequences of using it
;; or for whether it serves any particular purpose or works at all,
;; unless he says so in writing.  Refer to the GNU General Public
;; License for full details.
;;
;; Everyone is granted permission to copy, modify and redistribute
;; iso-html.el, but only under the conditions described in the
;; GNU General Public License.	 A copy of this license is
;; supposed to have been given to you along with GNU Emacs so you
;; can know your rights and responsibilities.  It should be in a
;; file named COPYING.	Among other things, the copyright notice
;; and this notice must be preserved on all copies.
;;

;;;----------------------------------------------------------------------------
;;; Variable definitions and initializations

(defvar iso-html-minor-mode nil
  "Variable indicating when iso-html-minor-mode is active.")

(or (assq 'iso-html-minor-mode minor-mode-alist)
    (setq minor-mode-alist (cons '(iso-html-minor-mode " ISO-HTML")
				 minor-mode-alist)))

(defvar iso-html-minor-mode-initialized nil
  "Variable indicating if iso-html-minor-mode is already initialized in this
buffer. This variable is buffer local.")

(make-variable-buffer-local 'iso-html-minor-mode-initialized)

(defvar html-2-iso-regex
  "&[a-zA-Z]*;"
  "Regular expression to pre-select substrings to be translated by html-2-iso.")
(defvar iso-2-html-regex "[�-�]"
  "Regular expression to pre-select substrings to be translated by iso-2-html.")
(defvar iso-2-html-alist nil
  "Alist of CHAR.STRING pairs used by iso-2-html.")
(defvar html-2-iso-alist nil
  "Alist of STRING.ISO-CHAR pairs used by html-2-iso.")

(defun define-iso-html (char &optional string &rest names)
  "Define a translation between ISO-8859/1 characters and Html sequences.
CHAR is the ISO-8859/1 character code as a single letter string.
If STRING is non nil then it is used as representation of CHAR.
The optional remaining arguments are used to translate Html sequences to
characters."
  (if string (setq iso-2-html-alist (cons 
				    (cons (string-to-char char) string) 
				    iso-2-html-alist)))
  (while names
    (setq html-2-iso-alist (cons (cons (car names) char) 
				html-2-iso-alist))
    (setq names (cdr names))
  )
)

(if (null iso-2-html-alist)
    (progn
;      (define-iso-html "�" "" ""	)
;      (define-iso-html "�" "" ""	)
;      (define-iso-html "�" "" ""	)
;      (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" "" 	)
 ;     (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" ""	)
 ;     (define-iso-html "�" "" ""	)
      (define-iso-html "�" "&Agrave;" "&Agrave;"	)
      (define-iso-html "�" "&Aacute;" "&Aacute;"	)
      (define-iso-html "�" "&Acirc;" "&Acirc;"	)
      (define-iso-html "�" "&Atilde;" "&Atilde;"	)
      (define-iso-html "�" "&Auml;" "&Auml;"	)
      (define-iso-html "�" "&Aring;" "&Aring;"	)
      (define-iso-html "�" "&AElig;" "&AElig;"	)
      (define-iso-html "�" "&Ccedil;" "&Ccedil;"	)
      (define-iso-html "�" "&Egrave;" "&Egrave;"	)
      (define-iso-html "�" "&Eacute;" "&Eacute;"	)
      (define-iso-html "�" "&Ecirc;" "&Ecirc;"	)
      (define-iso-html "�" "&Euml;" "&Euml;"	)
      (define-iso-html "�" "&Igrave;" "&Igrave;"	)
      (define-iso-html "�" "&Iacute;" "&Iacute;"	)
      (define-iso-html "�" "&Icirc;" "&Icirc;"	)
      (define-iso-html "�" "&Iuml;" "&Iuml;"	)
      (define-iso-html "�" "&ETH;" "&ETH;"	)
      (define-iso-html "�" "&Ntilde;" "&Ntilde;"	)
      (define-iso-html "�" "&Ograve;" "&Ograve;"	)
      (define-iso-html "�" "&Oacute;" "&Oacute;"	)
      (define-iso-html "�" "&Ocirc;" "&Ocirc;"	)
      (define-iso-html "�" "&Otilde;" "&Otilde;"	)
      (define-iso-html "�" "&Ouml;" "&Ouml;"	)
;      (define-iso-html "�" "" ""	)
      (define-iso-html "�" "&Oslash;" "&Oslash;"	)
      (define-iso-html "�" "&Ugrave;" "&Ugrave;"	)
      (define-iso-html "�" "&Uacute;" "&Uacute;"	)
      (define-iso-html "�" "&Ucirc;" "&Ucirc;"	)
      (define-iso-html "�" "&Uuml;" "&Uuml;"	)
      (define-iso-html "�" "&Yacute;" "&Yacute;"	)
      (define-iso-html "�" "&THORN;" "&THORN;"	)
      (define-iso-html "�" "&szlig;" "&szlig;"	)
      (define-iso-html "�" "&agrave;" "&agrave;"	)
      (define-iso-html "�" "&aacute;" "&aacute;"	)
      (define-iso-html "�" "&acirc;" "&acirc;"	)
      (define-iso-html "�" "&atilde;" "&atilde;"	)
      (define-iso-html "�" "&auml;" "&auml;"	)
      (define-iso-html "�" "&aring;" "&aring;"	)
      (define-iso-html "�" "&aelig;" "&aelig;"	)
      (define-iso-html "�" "&ccedil;" "&ccedil;"	)
      (define-iso-html "�" "&egrave;" "&egrave;"	)
      (define-iso-html "�" "&eacute;" "&eacute;"	)
      (define-iso-html "�" "&ecirc;" "&ecirc;"	)
      (define-iso-html "�" "&euml;" "&euml;"	)
      (define-iso-html "�" "&igrave;" "&igrave;"	)
      (define-iso-html "�" "&iacute;" "&iacute;"	)
      (define-iso-html "�" "&icirc;" "&icirc;"	)
      (define-iso-html "�" "&iuml;" "&iuml;"	)
      (define-iso-html "�" "&eth;" "&eth;"	)
      (define-iso-html "�" "&ntilde;" "&ntilde;"	)
      (define-iso-html "�" "&ograve;" "&ograve;"	)
      (define-iso-html "�" "&oacute;" "&oacute;"	)
      (define-iso-html "�" "&ocirc;" "&ocirc;"	)
      (define-iso-html "�" "&otilde;" "&otilde;"	)
      (define-iso-html "�" "&ouml;" "&ouml;"	)
;      (define-iso-html "�" "" ""	)
      (define-iso-html "�" "&oslash;" "&oslash;"	)
      (define-iso-html "�" "&ugrave;" "&ugrave;"	)
      (define-iso-html "�" "&uacute;" "&uacute;"	)
      (define-iso-html "�" "&ucirc;" "&ucirc;"	)
      (define-iso-html "�" "&uuml;" "&uuml;"	)
      (define-iso-html "�" "&yacute;" "&yacute;"	)
      (define-iso-html "�" "&thorn;" "&thorn;"	)
      (define-iso-html "�" "&yuml;" "&yuml;" 	)
))


;;;----------------------------------------------------------------------------
;;; Definition of the minor mode

(defun iso-html-minor-mode (&optional arg)
  "Minor mode to translate HTML sequences into ISO 8859/1 characters while 
visiting a file.
Provisions are made to translate them back when writing."
  (interactive)

  (if (null iso-html-minor-mode-initialized)
    (progn
      (setq iso-html-minor-mode-initialized t)
      (add-hook 'write-contents-hooks 'iso-html-write)
      ;; 
      (make-local-variable 'after-save-hook)
      (add-hook 'after-save-hook 'iso-html-after-write)
      ;; There seem to be two versions of this hook around
      ;; Horrible to use such undocumented features :-) 
      (make-local-variable 'after-save-hooks)
      (add-hook 'after-save-hooks 'iso-html-after-write)
      ;;
      (make-local-variable 'iso-html-minor-mode)
    )
  )
  (setq iso-html-minor-mode
	(if (null arg) (not iso-html-minor-mode)
	  (> (prefix-numeric-value arg) 0)))
  (if iso-html-minor-mode (html-2-iso) (iso-2-html) )
)

(defun iso-html-write ()
  "Function anchored in the local-write-file-hooks. It is not removed but 
disabled with the iso-html-minor-mode."
  (if iso-html-minor-mode (iso-2-html))
)

(defun iso-html-after-write ()
  "Function anchored in the after-save-hooks. It is not removed but 
disabled whith the iso-html-minor-mode."
  (if iso-html-minor-mode (html-2-iso))
)

(defun iso-2-html ()
  "Translate ISO-8859/1 extended characters into Html sequences.
The variable iso-2-html-regex is used to preselect a character which is then
translated using the variable iso-2-html-alist.
Use the function define-iso-html instead of setting iso-2-html-alist."

  (let ((buffer-read-only nil) 
	(state (buffer-modified-p)))
    (save-excursion
      (goto-char (point-min))
      (while (search-forward-regexp iso-2-html-regex (point-max) t)
	(let ((new (assq (string-to-char 
			   (buffer-substring 
			    (- (point) 1) 
			    (point))) 
			  iso-2-html-alist)))
	  (if new (progn (delete-backward-char 1)
			 (insert (cdr new)) )
	  )
	)
      )
    ) 
    (set-buffer-modified-p state)
  ) 
  nil
)

(defun html-2-iso ()
  "Translate Html sequences into ISO-8859/1 extended characters.
The variable html-2-iso-regex is used to preselect a character which is then
translated using the variable html-2-iso-alist.
Use the function define-iso-html instead of setting html-2-iso-alist."

  (let ((buffer-read-only nil) 
	(state (buffer-modified-p)))
    (save-excursion
      (goto-char (point-min))
      (while (search-forward-regexp html-2-iso-regex (point-max) t)
	(let ((hit (buffer-substring (match-beginning 0) (match-end 0)))
	      (b (match-beginning 0))
	      (e (match-end 0)) )
	  (setq hit (assoc hit html-2-iso-alist))
	  (if hit
	      (progn
		(delete-region b e)
		(insert (cdr hit))
	      )
	  )
	)
      )
    )
    (set-buffer-modified-p state)
  )
  nil
)

; ��������
; ��������
; ��������
; ��������
; ��������
; ��������
; ��������
; ��������
; ��������
; ��������
; ��������
; ��������
