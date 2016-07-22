"----------------------------------------------------
" neobundle.vim
"----------------------------------------------------
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
" NeoBundle 'Shougo/neocomplcache.git'
" NeoBundle 'Shougo/neocomplete.git'
NeoBundle 'Shougo/neobundle.vim.git'
" NeoBundle 'Shougo/neosnippet.vim.git'
" NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'Shougo/vimfiler.git'
NeoBundle 'Shougo/vimshell.git'
NeoBundle 'Shougo/vimproc.git'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'thinca/vim-quickrun.git'
NeoBundle 'thinca/vim-openbuf'
NeoBundle 'thinca/vim-ref.git'
"NeoBundle 'choplin/unite-vim_hacks'
NeoBundle 'tyru/open-browser.vim.git'
" NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'bling/vim-airline'
"NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'tomasr/molokai'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'nixprime/cpsm'
NeoBundle 'glidenote/memolist.vim'
NeoBundle 'vim-scripts/VimRepress'
NeoBundle 'tpope/vim-fugitive'
" NeoBundle 'davidhalter/jedi-vim', { 'rev': '3934359'}
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'nvie/vim-flake8'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'gosukiwi/vim-atom-dark'
NeoBundle 'dracula/vim'
NeoBundle 'scrooloose/nerdtree'

" NeoBundle 'Shougo/vinarise.git'
" NeoBundle 'Shougo/vim-vcs.git'
call neobundle#end()

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

"インデント設定
set autoindent
set tabstop=2
set shiftwidth=2
set smartindent

"表示関連
" カーソル行をハイライト
""" set cursorline
""" " カレントウィンドウにのみ罫線を引く
""" augroup cch
""" 	autocmd! cch
""" 	autocmd WinLeave * set nocursorline
""" 	autocmd WinEnter,BufRead * set cursorline
""" augroup END
""" hi clear CursorLine
""" hi CursorLine gui=underline
""" highlight CursorLine ctermbg=black guibg=black
" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
" set list
" set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

"補完関連
autocmd FileType * setlocal formatoptions-=ro

"Tags関連

"検索関連
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索文字列入力時に順次対象文字列にヒットさせない
set noincsearch
" Esc連打で検索時にハイライトを消す
nnoremap <Esc><Esc> :nohlsearch<CR>

"移動関連

"Color関連
set t_Co=256 
syntax enable
set background=dark
colorscheme dracula

"編集関連
set backspace=2
" OSのクリップボードを使用する
" set clipboard+=unnamed
" ターミナルでマウスを使用できるようにする
" set mouse=a
" set guioptions+=a
" set ttymouse=xterm2

"ヤンクした文字は、システムのクリップボードに入れる"
"set clipboard=unnamed


"その他
" insertモードを抜けるとIMEオフ
" aaaあああ
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


" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

" make, grep などのコマンド後に自動的にQuickFixを開く
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen

" QuickFixおよびHelpでは q でバッファを閉じる
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

"プラグイン関連
"----------------------------------------------------
" quickrun.vim
"----------------------------------------------------
let g:quickrun_config = {}
let g:quickrun_config['*'] = {'runmode': "async:remote:vimproc", 'split': 'below'}
let g:quickrun_config['markdown'] = {
      \ 'outputter': 'browser'
      \ }
let g:quickrun_config['html'] = {
			\ 'exec': 		'%c %s',
      \ 'outputter': 'browser'
      \ }

" for nosetest
" augroup QuickRunUnitTest
"   autocmd!
"   autocmd BufWinEnter,BufNewFile test_*.py set filetype=python.test
" augroup END
" " let g:quickrun_config['python.unit'] = {'command': 'nosetests', 'cmdopt': '-s -vv'}
" let g:quickrun_config['python.test'] = {'command': 'nosetests', 'exec': ['%c -v %s']}

" "------------------------------------
" " unite.vim
" "------------------------------------
" nnoremap    [unite]   <Nop>
" nmap    ,u [unite]
" """ " 全部乗せ
" nnoremap <silent> [unite]a  :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
" """ " ファイル一覧
" nnoremap <silent> [unite]f  :<C-u>Unite -buffer-name=files file<CR>
" """ " バッファ一覧
" nnoremap <silent> [unite]b  :<C-u>Unite buffer<CR>
" """ " 最近使用したファイル一覧
" nnoremap <silent> [unite]m  :<C-u>Unite file_mru<CR>
" """ " 常用セット
" nnoremap <silent> [unite]u  :<C-u>Unite buffer file_mru<CR>
" 
" autocmd FileType unite call s:unite_my_settings()
" function! s:unite_my_settings()"{{{
"   " Overwrite settings.
"   " ESCキーを2回押すと終了する
"   nmap <buffer> <ESC>      <Plug>(unite_exit)
"   nmap <buffer> <ESC><ESC> <Plug>(unite_exit)
"   imap <buffer> jj      <Plug>(unite_insert_leave)
"   nnoremap <silent><buffer> <C-k> :<C-u>call unite#mappings#do_action('preview')<CR>
"   imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
"   " Start insert.
"   let g:unite_enable_start_insert = 1
" endfunction"}}}
" 
" "------------------------------------
" " neocomplcache.vim
" "------------------------------------
" " " AutoComplPopを無効にする
" let g:acp_enableAtStartup = 0
" " " NeoComplCacheを有効にする
" " let g:neocomplcache_enable_at_startup = 1


"------------------------------------
" jedi.vim & neocomplete.vim
"------------------------------------
let g:jedi#auto_initialization = 1
let g:jedi#rename_command = "<leader>R"
let g:jedi#popup_on_dot = 1


" if !exists('g:neocomplete#force_omni_input_patterns')
"         let g:neocomplete#force_omni_input_patterns = {}
" endif

" let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'


"------------------------------------
" vim-powerline.vim
"------------------------------------
"let g:Powerline_symbols = 'fancy'

"------------------------------------
" vim-airline.vim
"------------------------------------
" let g:airline_powerline_fonts=1


"------------------------------------
" ctrlp.vim
"------------------------------------
let g:ctrlp_clear_cache_on_exit = 0

"------------------------------------
" memolist.vim
"------------------------------------
let g:memolist_path = "~/Dropbox/memolist_vim"
nmap ,mf :exe "CtrlP" g:memolist_path<cr><f5>
nmap ,mc :MemoNew<cr>
nmap ,mg :MemoGrep<cr>


" "------------------------------------
" " neosnippet.vim
" "------------------------------------
" imap <C-k>     <Plug>(neosnippet_expand_or_jump)
" smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" xmap <C-k>     <Plug>(neosnippet_expand_target)
" " Enable snipMate compatibility feature.
" let g:neosnippet#enable_snipmate_compatibility = 1
" " Tell Neosnippet about the other snippets
" let g:neosnippet#snippets_directory='~/.vim/snippets'
" " For snippet_complete marker.
" if has('conceal')
" 	  set conceallevel=2 concealcursor=i
" endif

"------------------------------------
" vim-flake8
"------------------------------------
autocmd FileType python map <buffer> <F8> :call Flake8()<CR>
let g:flake8_ignore="F403"
