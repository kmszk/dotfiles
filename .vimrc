" -----------------------------------------------------
"                     kmszk .vimrc                    
" -----------------------------------------------------
" vim-indent-guides の利用で必要
colorscheme default

" 文字コード設定
set encoding=utf-8	
set fileencoding=utf-8
set fileformat=unix

" 雑に打っても楽なように
nnoremap ; :

" basic settings 
set title
set nobackup
set smartindent		
set number
set autoindent

" Puttyの「ウインドウ」→「変換」→「CJK文字を…」のcheckを外す
" 三点リーダーとかは崩れるので崩れたらCtrl - lで再描写させる
set ambiwidth=double

" タブの幅
set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=0

" スワップファイルを作らない
set noswapfile

" undoファイルを作らない(for GVim)
set noundofile

" カッコのハイライト1表示、0非表示(効いていないっぽい)
let loaded_matchparen = 0 

" インクリメンタルサーチ 検索中にハイライトされる
set incsearch

" 検索時に大文字小文字を無視する
set ignorecase

" 検索ヒット文字をハイライト
set hlsearch

" C-vの矩形選択で行末より後ろもカーソルを置ける
set virtualedit=block

" 行の最後+1文字分カーソルを置ける
set virtualedit+=onemore

" バックスペースの挙動を7.2の時のように戻す
set backspace=indent,eol,start

" exモードに入らない
nnoremap Q <Nop>



"前回閉じたときのカーソルの位置を保存
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END


"------------------------------------------------------
" Start Neobundle Settings.
"------------------------------------------------------
"
" [初回インストールコマンド]
"
" mkdir -p ~/.vim/bundle
" git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
"

" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
  
" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'


"----------------------------------------------------
" StatusBar Plugin
"----------------------------------------------------
NeoBundle 'itchyny/lightline.vim'

" dotfilesのphp.snipを適応するには
" ln -s ~/dotfiles/.vim/bundle/vim-snippets/snippets/php.snip .vim/bundle/vim-snippets/snippets/php.snip 
"
" 編集中に
" :NeoSnippetEdit
" で現在開いているファイルタイプのスニペットを編集できる

set laststatus=2
if !has('gui_running')
	  set t_Co=256
endif

let g:airline_theme='PaperColor'
let g:lightline = {
	\ 'colorscheme': 'PaperColor' ,
    \ 'separator': { 'left': " >>", 'right': "<< " },
    \ 'subseparator': { 'left': " >>", 'right': "<< " },
	\ }

" "----------------------------------------------------
" " syntastic.vim PHPのシンタックスチェック
" "----------------------------------------------------
" NeoBundle 'scrooloose/syntastic'
" 
" let g:syntastic_check_on_open		 = 1
" let g:syntastic_enable_signs		 = 1
" let g:syntastic_echo_current_error	 = 1
" let g:syntastic_auto_loc_list		 = 2
" let g:syntastic_enable_highlighting	 = 1
" let g:syntastic_php_php_args		 = '-l'
" " set statusline+=%#warningmsg#
" " set statusline+=%{SyntasticStatuslineFlag()}
" " set statusline+=%*


" "----------------------------------------------------
" " Ctags コマンド自動化
" "----------------------------------------------------
" " :TagsGenerate
" " 大きめのプロジェクトでは生成に少し時間がかかる
" NeoBundle 'szw/vim-tags'
" 
" " ctags -f ~/.tags -R ~/project/ --exclude=.git --exclude=.svn
" set tags+=~/.tags
" 
" " 保存時に裏で自動でctagsを作成する
" let g:vim_tags_auto_generate = 1
" 
" " tag保存メインファイル名
" let g:vim_tags_main_file = '.tags'
" 
" " tagファイルのパス
" let g:vim_tags_extension = '~'
" 
" " 実行コマンド
" " ~/projectが設定されている前提
" let g:vim_tags_project_tags_command = "ctags -f ~/.tags -R ~/project --exclude=.git --exclude=.svn 2>/dev/null"


"----------------------------------------------------
" コメントアウトプラグイン
"----------------------------------------------------

NeoBundle "tyru/caw.vim.git"
nmap <C-K> <Plug>(caw:i:toggle)
vmap <C-K> <Plug>(caw:i:toggle)


"----------------------------------------------------
" Surround.Vim
"----------------------------------------------------

NeoBundle 'tpope/vim-surround'


"----------------------------------------------------
" Vim Neosnippet
"----------------------------------------------------
" 依存モジュール
NeoBundle 'Shougo/neocomplcache'

NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'



"----------------------------------------------------
" vim-indent-guides
"----------------------------------------------------
" インデントの色が256colorじゃないとキレイに出ない
" mv ~/.bashrc ~/.bashrc.orig
" ln -s ~/dotfiles/.bashrc ~/.bashrc
" ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf

" インデントに色を付けて見やすくする
NeoBundle 'nathanaelkane/vim-indent-guides'

" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup=1

let g:indent_guides_auto_colors = 0

" setting for Black Background
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=234
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=233

" setting for iTerms Solarized
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=none


"----------------------------------------------------
" ctrlp
"----------------------------------------------------
" ファイル名検索 git使ってるとgitのルートディレクトリを勝手に検知

NeoBundle "ctrlpvim/ctrlp.vim"



"----------------------------------------------------
call neobundle#end()
"----------------------------------------------------

" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
" 毎回聞かれると邪魔な場合もあるので、この設定は任意です。


NeoBundleCheck




" neosnipets用のセッティング
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif


" NeoBundleの前に書くと効かないらしい
syntax on	

