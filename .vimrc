"----------------------------------------------------
" neobundle.vim
"----------------------------------------------------
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

let $PATH = "~/.pyenv/shims:".$PATH

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim.git'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'thinca/vim-quickrun.git'
NeoBundle 'thinca/vim-openbuf'
NeoBundle 'thinca/vim-ref.git'
NeoBundle 'tyru/open-browser.vim.git'
NeoBundle 'bling/vim-airline'
"NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'nixprime/cpsm'
NeoBundle 'glidenote/memolist.vim'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'nvie/vim-flake8'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'mattn/vim-sqlfmt'
NeoBundle 'gosukiwi/vim-atom-dark'
NeoBundle 'dracula/vim'
NeoBundle 'fatih/vim-go'
NeoBundle 'MrPeterLee/VimWordpress'
NeoBundle 'prabirshrestha/async.vim'
NeoBundle 'prabirshrestha/vim-lsp'
NeoBundle 'sjl/badwolf'
NeoBundle 'vim-scripts/twilight'
NeoBundle 'morhetz/gruvbox'
NeoBundle 'joshdick/onedark.vim'
" NeoBundle 'colors/atom-dark.vim'

" NeoBundle 'scrooloose/nerdtree'
" NeoBundle 'justinmk/vim-dirvish'
call neobundle#end()

filetype plugin on
filetype indent on


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
runtime macros/matchit.vim

"Color関連
set t_Co=256 
syntax enable
"set background=dark
colorscheme dracula
" colorscheme vim-atom-dark

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
set autowrite


"その他
set helplang=ja

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
autocmd FileType python setlocal completeopt-=preview

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
set ambiwidth=double
let g:airline_powerline_fonts=1
" let g:airline_theme='papercolor'


"------------------------------------
" ctrlp.vim
"------------------------------------
" キャッシュディレクトリ
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'

" キャッシュを終了時に削除しない
let g:ctrlp_clear_cache_on_exit = 0

" 遅延再描画
let g:ctrlp_lazy_update = 1

" ルートパスと認識させるためのファイル
let g:ctrlp_root_markers = ['Gemfile', 'pom.xml', 'build.xml']

" CtrlPのウィンドウ最大高さ
let g:ctrlp_max_height = 20

" 無視するディレクトリ
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

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

"------------------------------------
" vim-go
"------------------------------------
"filetype off
"filetype plugin indent off
au FileType go setlocal sw=4 ts=4 sts=4 noet
" au FileType go setlocal makeprg=go\ build\ ./... errorformat=%f:%l:\ %m
"u BufWritePre *.go Fmt
"filetype plugin indent on
"syntax on
let g:go_fmt_command = "goimports"
let g:go_version_warning = 0


" if executable('gopls')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'gopls',
"         \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
"         \ 'whitelist': ['go'],
"         \ })
" "    autocmd BufWritePre *.go LspDocumentFormatSync
"     autocmd FileType go setlocal omnifunc=lsp#complete
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')
" endif

if executable('go-langserver')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'go-langserver',
        \ 'cmd': {server_info->['go-langserver', '-gocodecompletion']},
        \ 'whitelist': ['go'],
        \ })
"    autocmd BufWritePre *.go LspDocumentFormatSync
    autocmd FileType go setlocal omnifunc=lsp#complete
    au FileType go nnoremap <buffer><silent> gd :<C-u>LspDefinition<CR>
    au FileType go nnoremap <buffer><silent> gD :<C-u>LspReferences<CR>
    au FileType go nnoremap <buffer><silent> gs :<C-u>LspDocumentSymbol<CR>
    au FileType go nnoremap <buffer><silent> gS :<C-u>LspWorkspaceSymbol<CR>
    au FileType go nnoremap <buffer><silent> gQ :<C-u>LspDocumentFormat<CR>
    au FileType go vnoremap <buffer><silent> gQ :LspDocumentRangeFormat<CR>
    au FileType go nnoremap <buffer><silent> K :<C-u>LspHover<CR>
    au FileType go nnoremap <buffer><silent> <F1> :<C-u>LspImplementation<CR>
    au FileType go nnoremap <buffer><silent> <F2> :<C-u>LspRename<CR>
    au FileType go nnoremap <buffer><silent> <C-]> :<C-u>LspDefinition<CR>
 let g:lsp_log_verbose = 1
 let g:lsp_log_file = expand('~/vim-lsp.log')
endif

" if executable('bingo')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'bingo',
"         \ 'cmd': {server_info->['bingo', '-mode', 'stdio']},
"         \ 'whitelist': ['go'],
"         \ })
" "    autocmd FileType go setlocal omnifunc=lsp#complete
"  let g:lsp_log_verbose = 1
"  let g:lsp_log_file = expand('~/vim-lsp.log')
" endif
