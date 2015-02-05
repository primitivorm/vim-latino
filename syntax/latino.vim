if exists("b:current_syntax")
    finish
endif

let s:lat_cpo_save = &cpo
set cpo&vim

" type
syn keyword latType     logico entero decimal caracter cadena
" storage
syn keyword latTypeDecleration           clase lista diccionario principal constructor propiedad publica privada protegida
" repeat / condition / label
syn keyword latRepeat     hacer desde mientras hasta cuando
syn keyword latConditional    si sino elegir fin
syn keyword latLabel      caso salto constante romper continuar defecto retorno esta funcion
syn keyword latConstant     falso verdadero

syn match   latComment      "#.*$"

" Strings and constants
syn match   latSpecialError  contained "\\."
syn match   latSpecialCharError  contained "[^']"
" [1] 9.4.4.4 Character literals
syn match   latSpecialChar contained +\\["\\'0abfnrtvx]+
" unicode characters
syn match   latUnicodeNumber +\\\(u\x\{4}\|U\x\{8}\)+ contained contains=latUnicodeSpecifier
syn match   latUnicodeSpecifier  +\\[uU]+ contained
syn region  latVerbatimString  start=+@"+ end=+"+ skip=+""+ contains=latVerbatimSpec,@Spell
syn match   latVerbatimSpec  +@"+he=s+1 contained
syn region  latString    start=+"+  end=+"+ end=+$+ contains=latSpecialChar,latSpecialError,latUnicodeNumber,@Spell
syn match   latCharacter   "'[^']*'" contains=latSpecialChar,latSpecialCharError
syn match   latCharacter   "'\\''" contains=latSpecialChar
syn match   latCharacter   "'[^\\]'"
syn match   latNumber    "\<\(0[0-7]*\|0[xX]\x\+\|\d\+\)[lL]\=\>"
syn match   latNumber    "\(\<\d\+\.\d*\|\.\d\+\)\([eE][-+]\=\d\+\)\=[fFdD]\="
syn match   latNumber    "\<\d\+[eE][-+]\=\d\+[fFdD]\=\>"
syn match   latNumber    "\<\d\+\([eE][-+]\=\d\+\)\=[fFdD]\>"

"The default highlighting.
hi def link latType     Type
hi def link latTypeDecleration    StorageClass
hi def link latRepeat     Repeat
hi def link latConditional    Conditional
hi def link latLabel      Label
hi def link latConstant     Constant
hi def link latComment          Comment

hi def link latSpecialError   Error
hi def link latSpecialCharError   Error
hi def link latString     String
hi def link latVerbatimString   String
hi def link latVerbatimSpec   SpecialChar
hi def link latPreCondit      PreCondit
hi def link latCharacter      Character
hi def link latSpecialChar    SpecialChar
hi def link latNumber     Number
hi def link latUnicodeNumber    SpecialChar
hi def link latUnicodeSpecifier   SpecialChar
hi def link latTypeOf                    Keyword

let b:current_syntax = "lat"
let &cpo = s:lat_cpo_save
unlet s:lat_cpo_save

