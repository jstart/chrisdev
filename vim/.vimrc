" Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
"filetype plugin indent on
filetype plugin on

	" My Plugins
	Plugin 'airblade/vim-gitgutter'
	Plugin 'digitaltoad/vim-jade'
	Plugin 'editorconfig/editorconfig-vim'
	Plugin 'godlygeek/tabular'
	Plugin 'groenewege/vim-less'
	Plugin 'jnwhiteh/vim-golang'
	Plugin 'kchmck/vim-coffee-script'
	Plugin 'kien/ctrlp.vim'
	Plugin 'Lokaltog/powerline'
	Plugin 'Lokaltog/vim-easymotion'
	Plugin 'mattn/emmet-vim'
	Plugin 'nvie/vim-rst-tables'
	Plugin 'scrooloose/nerdtree'
	Plugin 'scrooloose/syntastic'
	Plugin 'tomtom/tcomment_vim'
	Plugin 'tpope/vim-fugitive'
	Plugin 'vim-scripts/applescript.vim'
	Plugin 'vim-scripts/localvimrc'
	Plugin 'xsbeats/vim-blade'
	"Plugin 'altercation/vim-colors-solarized'
	"Plugin 'flazz/vim-colorschemes'
	"Plugin 'nathanaelkane/vim-indent-guides'

	Plugin 'taglist.vim'

" General Settings
syntax on
set autoindent
set ts=4
set sw=4
set title
set visualbell
set ignorecase
set hlsearch
set incsearch
set autoread
set nobackup
set nowb
set noswapfile
set number
set relativenumber
set modelines=2
set backspace=indent,eol,start

autocmd BufNewFile,BufEnter .bash_custom  set ft=sh
autocmd BufNewFile,BufEnter *.applescript set ft=applescript
autocmd BufNewFile,BufEnter *.blade.php   set ft=blade
autocmd BufNewFile,BufEnter *.coffee      set ft=coffee
autocmd BufNewFile,BufEnter *.go          set ft=go
autocmd BufNewFile,BufEnter *.jade        set ft=jade
autocmd BufNewFile,BufEnter *.json        set ft=javascript
autocmd BufNewFile,BufEnter *.less        set ft=less
autocmd BufNewFile,BufEnter .slate        set ft=python
autocmd BufNewFile,BufEnter README        set ft=markdown

" Source the .vimrc file after saving it
" autocmd BufWritePost .vimrc source $MYVIMRC

" Make trailing whitespace annoyingly highlighted.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Key mappings
	let mapleader = ","

	map <C-j> <C-W>j
	map <C-k> <C-W>k
	map <C-h> <C-W>h
	map <C-l> <C-W>l

	" Easily resize windows with just + or - keys
	map + <C-W>+
	map - <C-W>-

	nore ; :
	imap jj <Esc>
	imap kk <Esc>

	map  <F1> <ESC>:wall<CR>
	imap <F1> <ESC>:wall<CR>

	set pastetoggle=<F2>

	nnoremap <F3> :set hlsearch!<CR>

	map  <F4> <ESC>:call ToggleNumbers()<CR>
	imap <F4> <ESC>:call ToggleNumbers()<CR>
	function! ToggleNumbers()
		if &relativenumber == 1
			set norelativenumber
			:GitGutterEnable
		elseif &number == 1
			set nonumber
			:GitGutterDisable
		elseif &number == 0 && $relativenumber == 0
			set relativenumber
			set number
			:GitGutterEnable
		endif
	endfunction

	nnoremap <F6> :call ToggleMouse()<CR>
	function! ToggleMouse()
		if &mouse == 'a'
			set mouse=
			echo "Mouse usage disabled"
		else
			set mouse=a
			echo "Mouse usage enabled"
		endif
	endfunction

" Colors
	" Needed for Solarized colors to work correctly on local Mac
	set background=light
	" colorscheme solarized
	let g:solarized_termcolors=256

	highlight Search ctermfg=White ctermbg=Red
	highlight LineNr ctermfg=10
	" highlight CursorLineNr ctermfg=1

" Plugins
	" Nerd Tree
	nmap <C-n> :NERDTreeToggle<CR>
	let NERDTreeDirArrows=0
	let NERDTreeShowHidden=1
	" Quit nerdtree if it's the last open
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

	" Taglist
	if !executable('exuberant-ctags')
		let loaded_taglist=1 " disable taglist
	endif
	map <F5> <ESC>:TlistToggle<CR>
	imap <F5> <ESC>:TlistToggle<CR>
	let tlist_php_settings = 'php;c:class;f:function'
	let Tlist_Use_Right_Window = 1

	" .lvimrc
	let g:localvimrc_sandbox=0
	let g:localvimrc_ask=0

	" Ctrl P
	set runtimepath^=~/Developer/dotfiles/vim/bundle/ctrlp.vim
	let g:ctrlp_max_height = 20
	let g:ctrlp_use_caching = 1
	let g:ctrlp_clear_cache_on_exit = 0
	let g:ctrlp_show_hidden = 1
	"nnoremap <c-p> :CtrlP /var/www<cr> "Can be used to override default base dir

	" Powerline
	set laststatus=2
	set encoding=utf-8
	set rtp+=~/Developer/dotfiles/vim/bundle/powerline/powerline/bindings/vim
	set t_Co=256
	let g:Powerline_symbols = "fancy"

	" Git Gutter
	highlight clear SignColumn
	let g:gitgutter_max_signs = 99999

	" Syntastic
	" disable for angular
	let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
	let g:loaded_syntastic_php_phpcs_checker = 1
