"----------------------------------------------------
" neobundle.vim
"----------------------------------------------------
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/

  call neobundle#rc(expand('~/.vim/bundle'))
endif

NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'Shougo/neobundle.vim.git'
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'Shougo/vimfiler.git'
NeoBundle 'Shougo/vimshell.git'
NeoBundle 'Shougo/vimproc.git'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'thinca/vim-quickrun.git'
NeoBundle 'thinca/vim-openbuf'
NeoBundle 'thinca/vim-ref.git'
NeoBundle 'choplin/unite-vim_hacks'
NeoBundle 'tyru/open-browser.vim.git'
NeoBundle 'hallison/vim-markdown.git'
NeoBundle 'altercation/vim-colors-solarized'

" NeoBundle 'Shougo/vinarise.git'
" NeoBundle 'Shougo/vim-vcs.git'

filetype plugin on
filetype indent on

"基本設定
set nobackup

"エンコーディング関連
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp,euc-jp,cp932
set fileformats=unix,dos,mac

"StatusLine設定
set laststatus=2
set statusline=%<%f\ %m%r%h%w[%Y]%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

"インデント設定
set autoindent
set tabstop=2
set shiftwidth=2
set smartindent

"表示関連
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

"補完関連

"Tags関連

"検索関連

"移動関連

"Color関連
set t_Co=256 
syntax enable
set background=dark
colorscheme solarized

"編集関連
set backspace=2
" OSのクリップボードを使用する
set clipboard+=unnamed
" ターミナルでマウスを使用できるようにする
set mouse=a
set guioptions+=a
set ttymouse=xterm2

"ヤンクした文字は、システムのクリップボードに入れる"
set clipboard=unnamed


"その他
" insertモードを抜けるとIMEオフ
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

"gvim(主に windows 用)
if has('gui_running')
	set guicursor=a:blinkon0
	set guioptions-=T
	set guioptions-=m
	set guioptions-=r
	if has('win32')
		" Windows用
		set guifont=MS_Gothic:h12:cSHIFTJIS
		"set guifont=MS_Mincho:h12:cSHIFTJIS
		" 行間隔の設定
		set linespace=1
		" 一部のUCS文字の幅を自動計測して決める
		if has('kaoriya')
			set ambiwidth=auto
		endif
	endif
endif

"プラグイン関連
"----------------------------------------------------
" quickrun.vim
"----------------------------------------------------
let g:quickrun_config = {}
let g:quickrun_config['markdown'] = {
      \ 'outputter': 'browser'
      \ }

"------------------------------------
" unite.vim
"------------------------------------
nnoremap    [unite]   <Nop>
nmap    ,u [unite]
""" " 全部乗せ
nnoremap <silent> [unite]a  :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
""" " ファイル一覧
nnoremap <silent> [unite]f  :<C-u>Unite -buffer-name=files file<CR>
""" " バッファ一覧
nnoremap <silent> [unite]b  :<C-u>Unite buffer<CR>
""" " 最近使用したファイル一覧
nnoremap <silent> [unite]m  :<C-u>Unite file_mru<CR>
""" " 常用セット
nnoremap <silent> [unite]u  :<C-u>Unite buffer file_mru<CR>

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  " Overwrite settings.
  " ESCキーを2回押すと終了する
  nmap <buffer> <ESC>      <Plug>(unite_exit)
  nmap <buffer> <ESC><ESC> <Plug>(unite_exit)
  imap <buffer> jj      <Plug>(unite_insert_leave)
  nnoremap <silent><buffer> <C-k> :<C-u>call unite#mappings#do_action('preview')<CR>
  imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
  " Start insert.
  let g:unite_enable_start_insert = 1
endfunction"}}}

"------------------------------------
" neocomplcache.vim
"------------------------------------
" AutoComplPopを無効にする
let g:acp_enableAtStartup = 0
" NeoComplCacheを有効にする
let g:neocomplcache_enable_at_startup = 1
