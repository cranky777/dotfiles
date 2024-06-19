"----------------------------------------------------
" neobundle.vim
"----------------------------------------------------
set nocompatible
filetype off

" let $PATH = "~/.pyenv/shims:".$PATH

call plug#begin('~/.vim/bundle')
Plug 'vim-jp/vimdoc-ja'
Plug 'mattn/webapi-vim'
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-openbuf'
Plug 'thinca/vim-ref'
Plug 'tyru/open-browser.vim'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
"Plug 'altercation/vim-colors-solarized'
Plug 'nanotech/jellybeans.vim'
Plug 'tomasr/molokai'
"Plug 'kien/ctrlp.vim'
Plug 'nixprime/cpsm'
Plug 'glidenote/memolist.vim'
" Plug 'davidhalter/jedi-vim'
" Plug 'nvie/vim-flake8'
Plug 'mattn/emmet-vim'
Plug 'mattn/vim-sqlfmt'
Plug 'gosukiwi/vim-atom-dark'
Plug 'dracula/vim'
Plug 'sainnhe/edge'
" Plug 'fatih/vim-go'
" Plug 'MrPeterLee/VimWordpress'

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'mattn/vim-lsp-icons'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'sjl/badwolf'
Plug 'vim-scripts/twilight'
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'cocopon/iceberg.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-repeat'
Plug 'jacoborus/tender.vim'
Plug 'tpope/vim-fugitive'
" Plug 'colors/atom-dark.vim'
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'previm/previm'

" Plug 'scrooloose/nerdtree'
" Plug 'justinmk/vim-dirvish'
" call neobundle#end()
Plug 'skanehira/qfopen.vim'
call plug#end()

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

"キーマッピング
nnoremap ZQ <Nop>
nnoremap Q <Nop>
noremap <C-j> <esc>
noremap! <C-j> <esc>

" コマンド
command! -nargs=1 -complete=help Vhelp :vertical belowright help <args>
nnoremap <Space>h :<C-u>vert bel h<Space>

"補完関連
autocmd FileType * setlocal formatoptions-=ro

"Tags関連
set tags+=.git/tags
"" fugitive
autocmd BufWritePost *
      \ if exists('b:git_dir') && !empty(glob(b:git_dir.'/hooks/ctags')) |
      \   call system('"'.b:git_dir.'/hooks/ctags"') |
      \ endif

"検索関連
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索時に最後まで行ったら最初に戻る
" set wrapscan
" 検索時に最後まで行ったら最初に戻らない
set nowrapscan
" 検索文字列入力時に順次対象文字列にヒットさせない
set noincsearch
" Esc連打で検索時にハイライトを消す
nnoremap <Esc><Esc> :nohlsearch<CR>
" 相対PATHを扱えるようにする
autocmd FileType html setlocal includeexpr=substitute(v:fname,'^\\/','','') | setlocal path+=;/

"移動関連
runtime macros/matchit.vim

"Color関連
set t_Co=256 
"set background=dark
syntax enable
colorscheme jellybeans
"colorscheme dracula
"hi Comment ctermfg=DarkCyan
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

" MoveToNewTab
nnoremap <silent> tm :<C-u>call <SID>MoveToNewTab()<CR>
function! s:MoveToNewTab()
    tab split
    tabprevious

    if winnr('$') > 1
        close
    elseif bufnr('$') > 1
        buffer #
    endif

    tabnext
endfunction

" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

" quickfix
" make, grep などのコマンド後に自動的にQuickFixを開く
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen
nnoremap [q :cprevious<CR>   " 前へ
nnoremap ]q :cnext<CR>       " 次へ
nnoremap [Q :<C-u>cfirst<CR> " 最初へ
nnoremap ]Q :<C-u>clast<CR>  " 最後へ

" QuickFixおよびHelpでは q でバッファを閉じる
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

"プラグイン関連
"----------------------------------------------------
" markdown
"----------------------------------------------------
let g:vim_markdown_folding_disabled = 1
let g:previm_enable_realtime = 1
let g:previm_open_cmd = 'google-chrome'

"----------------------------------------------------
" quickrun.vim
"----------------------------------------------------
" let g:quickrun_config = {}
" let g:quickrun_config['*'] = {'runmode': "async:remote:vimproc", 'split': 'below'}
" let g:quickrun_config['markdown'] = {
"       \ 'outputter': 'browser'
"       \ }
" let g:quickrun_config['html'] = {
" 			\ 'exec': 		'%c %s',
"       \ 'outputter': 'browser'
"       \ }
" 
"------------------------------------
" jedi.vim & neocomplete.vim
"------------------------------------
" let g:jedi#auto_initialization = 1
" let g:jedi#rename_command = "<leader>R"
" let g:jedi#popup_on_dot = 1
" autocmd FileType python setlocal completeopt-=preview

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
"let g:airline_powerline_fonts=1
"let g:airline#extensions#tabline#enabled = 1

let g:lightline = {
			\ 'active': {
				\   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
				\   'gitbranch': 'fugitive#head'
      \ },
		\ }


"------------------------------------
" ctrlp.vim
"------------------------------------
""" " キャッシュディレクトリ
""" let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
""" 
""" " キャッシュを終了時に削除しない
""" let g:ctrlp_clear_cache_on_exit = 0
""" 
""" " 遅延再描画
""" let g:ctrlp_lazy_update = 1
""" 
""" " ルートパスと認識させるためのファイル
""" let g:ctrlp_root_markers = ['Gemfile', 'pom.xml', 'build.xml']
""" 
""" " CtrlPのウィンドウ最大高さ
""" let g:ctrlp_max_height = 20
""" 
""" " 無視するディレクトリ
""" let g:ctrlp_custom_ignore = {
"""   \ 'dir':  '\v[\/]\.(git|hg|svn)$',
"""   \ 'file': '\v\.(exe|so|dll)$',
"""   \ 'link': 'some_bad_symbolic_links',
"""   \ }

"------------------------------------
" fzf.vim
"------------------------------------
" nnoremap <C-b> :Buffers<CR>
" nnoremap <C-g> :Rg<Space>
nnoremap <leader><leader> :Commands<CR>
nnoremap <C-p> :Files<CR>
let g:fzf_action = {
  \ 'ctrl-o': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit'
  \ }

"------------------------------------
" memolist.vim
"------------------------------------
let g:memolist_path = "~/Dropbox/memolist_vim"
let g:memolist_fzf = 1
nmap ,mc :MemoNew<cr>
nmap ,mg :MemoGrep<cr>

"------------------------------------
" vim-flake8
"------------------------------------
" autocmd FileType python map <buffer> <F8> :call Flake8()<CR>
" let g:flake8_ignore="F403"

"------------------------------------
" vim-go
"------------------------------------
"filetype off
"filetype plugin indent off
autocmd FileType go setlocal sw=4 ts=4 sts=4 noet
autocmd FileType python setlocal sw=4 sts=4 ts=4 et
autocmd! BufWritePre *.go call execute('LspDocumentFormatSync') | call execute('LspCodeActionSync source.organizeImports')
autocmd! BufWritePre *.py call execute('LspDocumentFormatSync')
let g:lsp_diagnostics_echo_cursor = 1
" au FileType go setlocal makeprg=go\ build\ ./... errorformat=%f:%l:\ %m
"u BufWritePre *.go Fmt
"filetype plugin indent on
"syntax on
" let g:go_fmt_command = "goimports"
" let g:go_version_warning = 0

"------------------------------------
" easymotion
"------------------------------------
map <Leader> <Plug>(easymotion-prefix)
map f <Plug>(easymotion-fl)
map t <Plug>(easymotion-tl)
map F <Plug>(easymotion-Fl)
map T <Plug>(easymotion-Tl)
nmap <Leader>s <Plug>(easymotion-s2)
xmap <Leader>s <Plug>(easymotion-s2)


"------------------------------------
" easymotion
"------------------------------------

if empty(globpath(&rtp, 'autoload/lsp.vim'))
  finish
endif

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> <f2> <plug>(lsp-rename)
  inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log')

let g:lsp_diagnostics_enabled = 0
let g:lsp_diagnostics_echo_cursor = 0
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 1
let g:asyncomplete_popup_delay = 200
let g:lsp_text_edit_enabled = 1

""   if executable('go-langserver')
""       au User lsp_setup call lsp#register_server({
""           \ 'name': 'go-langserver',
""           \ 'cmd': {server_info->['go-langserver', '-gocodecompletion']},
""           \ 'whitelist': ['go'],
""           \ })
""   "    autocmd BufWritePre *.go LspDocumentFormatSync
""       autocmd FileType go setlocal omnifunc=lsp#complete
""       au FileType go nnoremap <buffer><silent> gd :<C-u>LspDefinition<CR>
""       au FileType go nnoremap <buffer><silent> gD :<C-u>LspReferences<CR>
""       au FileType go nnoremap <buffer><silent> gs :<C-u>LspDocumentSymbol<CR>
""       au FileType go nnoremap <buffer><silent> gS :<C-u>LspWorkspaceSymbol<CR>
""       au FileType go nnoremap <buffer><silent> gQ :<C-u>LspDocumentFormat<CR>
""       au FileType go vnoremap <buffer><silent> gQ :LspDocumentRangeFormat<CR>
""       au FileType go nnoremap <buffer><silent> K :<C-u>LspHover<CR>
""       au FileType go nnoremap <buffer><silent> <F1> :<C-u>LspImplementation<CR>
""       au FileType go nnoremap <buffer><silent> <F2> :<C-u>LspRename<CR>
""       au FileType go nnoremap <buffer><silent> <C-]> :<C-u>LspDefinition<CR>
""    let g:lsp_log_verbose = 1
""    let g:lsp_log_file = expand('~/vim-lsp.log')
""    let lsp_signature_help_enabled = 0
""   endif

" if executable('fcitx')
" 	autocmd InsertLeave * :call system('fcitx-remote -c')
" 	autocmd CmdlineLeave * :call system('fcitx-remote -c')
" endif
" inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

let g:netrw_winsize = 30
let g:netrw_altv = 1
let g:netrw_alto = 0
let g:netrw_preview = 1

" qfopen
augroup qfopen-bufenter
  function! s:qfopen_keymap() abort
    map <buffer> a <Plug>(qfopen-action)
    map <buffer> <C-v> <Plug>(qfopen-open-vsplit)
    map <buffer> <C-x> <Plug>(qfopen-open-split)
    map <buffer> <C-t> <Plug>(qfopen-open-tab)
  endfunction
  au!
  au FileType qf call s:qfopen_keymap()
augroup END
