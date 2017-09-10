if exists("b:current_syntax")
    finish
endif

let s:lat_cpo_save = &cpo
set cpo&vim

" type
" syn keyword latType               logico entero decimal caracter cadena
" storage
" syn keyword latTypeDecleration    clase lista diccionario principal constructor propiedad publica privada protegida
" repeat / condition / label
syn keyword latRepeat      desde mientras repetir   hasta   por  cada    en
syn keyword latConditional global   si       osi    sino      fin     elegir    caso    defecto
syn keyword latLabel       romper   continuar retorno   ret     retornar    esta    funcion    fun
syn keyword latConstant    falso    verdadero
syn match cCustomFunc /\w\+\s*(/me=e-1,he=e-1

" Operators: 
syn cluster	latOperGroup	contains=latOper,latOperParen,latNumber,latString
syn match	latOper	"\(==\|!=\|>=\|<=\|\~=\|>\|<\|=\)[?#]\{0,2}"	skipwhite nextgroup=latString
syn match	latOper	"||\|&&\|[!-+.*\/%^\[\]\(\)]"	skipwhite nextgroup=latString

syn match   latComment     "#.*$"
" cCommentGroup allows adding matches for special things in comments
syn cluster	cCommentGroup	contains=cTodo,cBadContinuation

if exists("c_comment_strings")
  " A comment can contain cString, cCharacter and cNumber.
  " But a "*/" inside a cString in a cComment DOES end the comment!  So we
  " need to use a special type of cString: cCommentString, which also ends on
  " "*/", and sees a "*" at the start of the line as comment again.
  " Unfortunately this doesn't very well work for // type of comments :-(
  syn match	cCommentSkip	contained "^\s*\*\($\|\s\+\)"
  syn region cCommentString	contained start=+L\=\\\@<!"+ skip=+\\\\\|\\"+ end=+"+ end=+\*/+me=s-1 contains=cSpecial,cCommentSkip
  syn region cComment2String	contained start=+L\=\\\@<!"+ skip=+\\\\\|\\"+ end=+"+ end="$" contains=cSpecial
  syn region  cCommentL	start="//" skip="\\$" end="$" keepend contains=@cCommentGroup,cComment2String,cCharacter,cNumbersCom,cSpaceError,@Spell
  if exists("c_no_comment_fold")
    " Use "extend" here to have preprocessor lines not terminate halfway a
    " comment.
    syn region cComment	matchgroup=cCommentStart start="/\*" end="\*/" contains=@cCommentGroup,cCommentStartError,cCommentString,cCharacter,cNumbersCom,cSpaceError,@Spell extend
  else
    syn region cComment	matchgroup=cCommentStart start="/\*" end="\*/" contains=@cCommentGroup,cCommentStartError,cCommentString,cCharacter,cNumbersCom,cSpaceError,@Spell fold extend
  endif
else
  syn region	cCommentL	start="//" skip="\\$" end="$" keepend contains=@cCommentGroup,cSpaceError,@Spell
  if exists("c_no_comment_fold")
    syn region	cComment	matchgroup=cCommentStart start="/\*" end="\*/" contains=@cCommentGroup,cCommentStartError,cSpaceError,@Spell extend
  else
    syn region	cComment	matchgroup=cCommentStart start="/\*" end="\*/" contains=@cCommentGroup,cCommentStartError,cSpaceError,@Spell fold extend
  endif
endif
" keep a // comment separately, it terminates a preproc. conditional
syn match	cCommentError	display "\*/"
syn match	cCommentStartError display "/\*"me=e-1 contained

" Strings and constants
syn match latSpecialError     contained "\\\\."
syn match latSpecialCharError contained "[$?]"
" [1] 9.4.4.4 Character literals
syn match   latSpecialChar          contained +\\["\\'0abfnrtvx]+
" unicode characters
syn match   latUnicodeNumber        +\\\(u\x\{4}\|U\x\{8}\)+ contained contains=latUnicodeSpecifier
syn match   latUnicodeSpecifier     +\\[uU]+ contained
syn region  latVerbatimString       start=+@"+ end=+"+ skip=+""+ contains=latVerbatimSpec,@Spell
syn match   latVerbatimSpec         +@"+he=s+1 contained
syn region  latString               start=+"+  end=+"+ end=+$+ contains=latSpecialChar,latSpecialError,latUnicodeNumber,@Spell
syn region  latString               start=+'+  end=+'+ end=+$+ contains=latSpecialChar,latSpecialError,latUnicodeNumber,@Spell
syn match   latCharacter        "'[^']*'" contains=latSpecialChar,latSpecialCharError
syn match   latCharacter        "'\\''" contains=latSpecialChar
syn match   latCharacter        "'[^\\]'"
syn match   latNumber           "\<\(0[0-7]*\|0[xX]\x\+\|\d\+\)[lL]\=\>"
syn match   latNumber           "\(\<\d\+\.\d*\|\.\d\+\)\([eE][-+]\=\d\+\)\=[fFdD]\="
syn match   latNumber           "\<\d\+[eE][-+]\=\d\+[fFdD]\=\>"
syn match   latNumber           "\<\d\+\([eE][-+]\=\d\+\)\=[fFdD]\>"
syn match   latFunction         "[a-zA-Z_][a-zA-Z0-9_]*" display contained
syn match   latFunction         "\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained

"The default highlighting.
hi def link latType             Type
hi def link latTypeDecleration  StorageClass
hi def link latRepeat           Repeat
hi def link latConditional      Conditional
hi def link latLabel            Label
hi def link latConstant         Constant
hi def link latComment          Comment
hi def link cCommentL		cComment
hi def link cCommentStart	cComment
hi def link cCommentError	cError
hi def link cCommentStartError	cError
hi def link cCommentString	cString
hi def link cComment2String	cString
hi def link cCommentSkip	cComment
hi def link cComment		Comment
hi def link latSpecialError     Error
hi def link latSpecialCharError Error
hi def link latString           String
hi def link latVerbatimString   String
hi def link latVerbatimSpec     SpecialChar
hi def link latPreCondit        PreCondit
hi def link latCharacter        Character
hi def link latSpecialChar      SpecialChar
hi def link latNumber           Number
hi def link latUnicodeNumber    SpecialChar
hi def link latUnicodeSpecifier SpecialChar
hi def link latTypeOf           Keyword
hi def link latFunction         Function
hi def link latOperError	    Error
hi def link latOper	            Operator
hi def link cCustomFunc         Function

let b:current_syntax = "lat"
let &cpo = s:lat_cpo_save
unlet s:lat_cpo_save

