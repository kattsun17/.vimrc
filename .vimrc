"---------------------------------------------------------------------------
" 日本語対応:
"
source ~/.vim/rc/encoding.rc.vim

"---------------------------------------------------------------------------
"help japanese
"
helptags ~/.vim/help/vimdoc-ja/doc
set runtimepath+=~/.vim/help/vimdoc-ja
set helplang=ja

"---------------------------------------------------------------------------
" 改行したときの挙動についての設定:
"
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

""set smartindent

"---------------------------------------------------------------------------
" 編集に関する設定:
"
" タブの画面上での幅
set tabstop=4
" 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set softtabstop=4
" 自動インデントでずれる幅
set shiftwidth=4
" タブをスペースに展開する/ しない (expandtab:展開する)
set expandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
" viとの互換性を停止
set nocompatible
 
"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
" タイトルを表示する
set title
" 行番号を表示 (nonumber:非表示)
set number
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
set nolist
" どの文字でタブや改行を表示するかを設定
"set listchars=tab:>-,extends:<,trail:-,eol:<
set background=dark
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" モードを表示する
set showmode
" タイトルを表示
set title
" 背景
"set background black
 
"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
"set nobackup
" スワップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
set noswapfile
" シンタックスハイライト
syntax on


"---------------------------------------------------------------------------
" 自動補完:
"
set completeopt=menuone
for k in split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_",'\zs')
  exec "imap <expr> " . k . " pumvisible() ? '" . k . "' : '" . k . "\<C-X>\<C-P>\<C-N>'"
endfor

"---------------------------------------------------------------------------
" 閉じ括弧を入力:
"
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
""inoremap < <><LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>

"---------------------------------------------------------------------------
" key-mapping
"
inoremap jj <Esc>

"---------------------------------------------------------------------------
" 挿入モード時、ステータスラインの色を変える:
"
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

"---------------------------------------------------------------------------
" 全角スペースの可視化:
"
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif

"---------------------------------------------------------------------------
" bundle
"
set nocompatible
filetype off
set rtp+=~/.vim/vundle.git
call vundle#rc()

Bundle 'neocomplcache'
Bundle 'nerdtree'
Bundle 'maxmellon/molokai'
filetype plugin indent on

set number
set relativenumber
try
    colorscheme molokai
    let g:molokai_original = 1
catch
    colorscheme elflord
endtry
set ttyfast
set ttyscroll=300

