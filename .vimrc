set nonumber
set hlsearch
set incsearch
set ruler
set tabstop=3
inoremap kj <ESC>
let mapleader = "<Space>"

" VIM-Plug plugin manager
call plug#begin('~\vimfiles\plugged')
	Plug 'scrooloose/nerdtree'
call plug#end()

" Finding Files:
" Search down into subfolders
set path+=**
" Display all matching files when we tab complete
set wildmenu
" Now we can hit tab to :find by partial match, use * to make it fuzzy

" Autocomplete, documented in |ins-completion|
" Highlights:
"	- ^n for anything, works well out of the box (^n-next, ^p-prev)
"		- configurable with the 'complete' option
"	- ^x^n for JUST this file
"	- ^x^f for filenames
"	- ^x^] for tags only
 
set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
