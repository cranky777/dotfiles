"----------------------------------------------------
" neobundle.vim
"----------------------------------------------------
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/

  call neobundle#rc(expand('~/.vim/bundle'))
endif

"neocomplcache.vim
"quickrun.vim
"vimproc + quickrun
"unite.vim

NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'Shougo/neobundle.vim.git'
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'Shougo/vimfiler.git'
NeoBundle 'Shougo/vimshell.git'
NeoBundle 'Shougo/vimproc.git'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'thinca/vim-quickrun.git'
NeoBundle 'thinca/vim-openbuf'
NeoBundle 'choplin/unite-vim_hacks'
NeoBundle 'tyru/open-browser.vim.git'
NeoBundle 'https://github.com/hallison/vim-markdown.git'

" NeoBundle 'Shougo/vinarise.git'
" NeoBundle 'Shougo/vim-vcs.git'

" Color Scheme
NeoBundle 'altercation/vim-colors-solarized'

filetype plugin on
filetype indent on
" neobundle.vim end

set encoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp,euc-jp,cp932
"set fileencodings=iso-2022-jp,utf-8,ucs-bom,euc-jp,cp932
set fileformats=unix,dos,mac
set t_Co=256 

"markdown
let g:quickrun_config = {}
let g:quickrun_config['markdown'] = {
      \ 'outputter': 'browser'
      \ }

"color
syntax enable
set background=dark
colorscheme solarized

"オートインデント
set autoindent
"タブ幅を設定する
set tabstop=2
set shiftwidth=2
set smartindent
"ステータスラインを常に表示
set laststatus=2
"ステータスラインに文字コードと改行文字を表示する
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

" insertモードを抜けるとIMEオフ
" set noimdisable
" set iminsert=0 imsearch=0
" set noimcmdline
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

" カーソル行をハイライト
set cursorline
" カレントウィンドウにのみ罫線を引く
augroup cch
	autocmd! cch
	autocmd WinLeave * set nocursorline
	autocmd WinEnter,BufRead * set cursorline
augroup END

hi clear CursorLine
hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black
