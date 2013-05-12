call pathogen#infect()
call pathogen#helptags()

" Syntax and filetype specific indentation and plugins on
syntax enable
filetype on
filetype plugin on
filetype indent on

" Shut up.
set noerrorbells
set visualbell

" Basic stuff
set clipboard=unnamed
set showmode
set history=500
set nocompatible
set hidden
set wildmenu
set scrolloff=5
set number
set cursorline
set colorcolumn=80
" set textwidth=80
set nowrap
set showmatch
set backspace=2

" Time out on key codes, not mappings.
set notimeout
set ttimeout
set ttimeoutlen=10

" Backup
set undofile
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set backup
set noswapfile

" Folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" Resize vim windows when resizing the main window
au VimResized * :wincmd =

" Searching
set incsearch
set hlsearch
set ignorecase

" Indenting
set tabstop=2
set shiftwidth=2
set softtabstop=2
set shiftround
set expandtab

set statusline=%<\ %{mode()}\ \|\ %f%m\ \|\ %{fugitive#head()\ }
set statusline+=%=\ %{&fileformat}\ \|\ %{&fileencoding}\ \|\ %{&filetype}\ \|\ %p%%\ 

set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set ruler
set laststatus=2

" ctags tags file
set tags=./tags;

" Do not add comments when making new line above/below comment
set formatoptions-=or

"""""""""""""""""""
" Mappings
"
" <leader> is ,
let mapleader = ","
noremap \ ,

" Move around splits with <C-[hjkl]>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Move sanely through wrapped lines
nnoremap k gk
nnoremap j gj

" Toggle paste mode
nmap <silent> <leader>p :set invpaste<CR>:set paste?<CR>

" Toggle hlsearch
nmap <silent> <leader>h :set invhlsearch<CR>

" Open and source vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
" Wipe out ALL the buffers
nmap <silent> <leader>bw :0,999bwipeout<CR>
" Delete current buffer
nmap <silent> <leader>bd :bd<CR>
" Close current window
nmap <silent> <leader>q <C-w>q
" Delete all trailing whitespaces
nmap <silent> <leader>tw :%s/\s\+$//<CR>

" Ruby
nmap <leader>ru :!ruby %<CR>
" Converting symbols from ruby 1.8 syntax to 1.9
nmap <silent> <leader>19 hf:xepld3l
" Converting ruby symbols to strings
nmap <silent> <leader>tst f:xviwS"
" Insert hashrocket
imap <c-l> <space>=><space>

" Brittle function to convert instance variables in rspec tests
" to let statements
function! InstanceToLet()
  normal "zdt=w
  normal "xd$
  normal ?doOlet(:"zpF@xEa) doend
  normal O"xp==``dd
endfunction

nmap <leader>itol :call InstanceToLet()<CR>

" node.js
nmap <leader>no :!node %<CR>

" Golang
nmap <leader>gos :e /usr/local/go/src/pkg/<CR>

" Running tests
" ,rt runs rspec on current (or previously set ) single spec ('run this')
" ,rf runs rspec on current (or previously set) spec file ('run file')
" ,ra runs all specs ('run all')
nmap <silent> <leader>rt :call RunNearestTest()<CR>
nmap <silent> <leader>rf :call RunTestFile()<CR>
nmap <silent> <leader>ra :call RunTests('')<CR>


""""""""""""""""""""""""
"
" Setting test file/single test and running it
"
function! RunTestFile(...)
  if a:0
    let command_suffix = a:1
  else
    let command_suffix = ""
  endif

  let in_test_file = match(expand("%"), '_spec.rb$') != -1
  if in_test_file
    call SetTestFile()
  elseif !exists("t:grb_test_file")
    return
  end
  call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
  let in_test_file = match(expand("%"), '_spec.rb$') != -1
  if in_test_file
    let t:grb_test_file_line=line(".")
  elseif !exists("t:grb_test_file_line")
    return
  end
  call RunTestFile(":" . t:grb_test_file_line)
endfunction

function! SetTestFile()
  let t:grb_test_file=@%
endfunction

function! RunTests(filename)
  :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
  :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo

  if filereadable("zeus.json")
    exec ":!zeus rspec " . a:filename
  elseif filereadable("Gemfile")
    exec ":!bundle exec rspec --color " . a:filename
  else
    exec ":!rspec --color " . a:filename
  end
endfunction

" Renaming a file
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>rn :call RenameFile()<cr>

"""""""""""""""""""
" Plugin Configuration
"
" CTRL-P
" Don't mess with my working directory!
let g:ctrlp_working_path_mode = 0
let g:ctrl_max_height = 20
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/vendor/bundle/*,*/node_modules/*
" Clear cache with ,cc
nmap <leader>cc :CtrlPClearAllCaches<CR>

" Powerline
let g:Powerline_symbols = 'fancy'

" Tabular
nmap <leader>a= :Tabularize /=<CR>
vmap <leader>a= :Tabularize /=<CR>
nmap <leader>ah :Tabularize /=>\?<CR>
vmap <leader>ah :Tabularize /=>\?<CR>
nmap <leader>a: :Tabularize /:\zs<CR>
vmap <leader>a: :Tabularize /:\zs<CR>

" Rails.vim
let g:rails_no_abbreviations = 1

"""""""""""""""""""
" Filetypes
"

" Ruby
augroup ft_ruby
  au!
  au Filetype ruby setlocal foldmethod=syntax
  au Filetype ruby setlocal foldlevel=9
augroup END

" Rspec Files
autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it specify it_should_behave_like before after setup subject its shared_examples_for shared_context let
highlight def link rubyRspec Function

" eruby, html
augroup ft_html
  au!
  au BufNewFile,BufRead *.html.erb setlocal filetype=eruby.html
augroup END

augroup ft_markdown
  au!
  au BufNewFile,BufRead *.md setlocal filetype=markdown
augroup END

autocmd FileType c setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType go setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4 nolist

au BufNewFile,BufRead *.ejs set filetype=html

"""""""""""""""""""
" GPG
" Transparent editing of gpg encrypted files.
" By Wouter Hanegraaff <wouter@blub.net>
augroup encrypted
  au!

  " First make sure nothing is written to ~/.viminfo while editing
  " an encrypted file.
  autocmd BufReadPre,FileReadPre      *.gpg set viminfo=
  " We don't want a swap file, as it writes unencrypted data to disk
  autocmd BufReadPre,FileReadPre      *.gpg set noswapfile
  autocmd BufReadPre,FileReadPre      *.gpg set noundofile
  autocmd BufReadPre,FileReadPre      *.gpg set nobackup
  " Switch to binary mode to read the encrypted file
  autocmd BufReadPre,FileReadPre      *.gpg set bin
  autocmd BufReadPre,FileReadPre      *.gpg let ch_save = &ch|set ch=2
  autocmd BufReadPre,FileReadPre      *.gpg let shsave=&sh
  autocmd BufReadPre,FileReadPre      *.gpg let &sh='sh'
  autocmd BufReadPre,FileReadPre      *.gpg let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost    *.gpg '[,']!gpg --decrypt --default-recipient-self 2> /dev/null
  autocmd BufReadPost,FileReadPost    *.gpg let &sh=shsave

  " Switch to normal mode for editing
  autocmd BufReadPost,FileReadPost    *.gpg set nobin
  autocmd BufReadPost,FileReadPost    *.gpg let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost    *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

  " Convert all text to encrypted text before writing
  autocmd BufWritePre,FileWritePre    *.gpg set bin
  autocmd BufWritePre,FileWritePre    *.gpg let shsave=&sh
  autocmd BufWritePre,FileWritePre    *.gpg let &sh='sh'
  autocmd BufWritePre,FileWritePre    *.gpg '[,']!gpg --encrypt --default-recipient-self 2>/dev/null
  autocmd BufWritePre,FileWritePre    *.gpg let &sh=shsave

  " Undo the encryption so we are back in the normal text, directly
  " after the file has been written.
  autocmd BufWritePost,FileWritePost  *.gpg   silent u
  autocmd BufWritePost,FileWritePost  *.gpg set nobin
augroup END

" GVim
if has("gui_running")
  set guioptions=gc
  set lines=60 columns=90
else
  set t_Co=256
endif

set background=dark
colorscheme jellybeans

" Fonts
if has("mac")
  set guifont=Inconsolata:h15
else
  set guifont=Monospace\ 9
endif
