set nocompatible
let mapleader = ","

set shell=/bin/bash

" install plugins using vim-plug
call plug#begin('~/.local/share/nvim/site/autoload')

" monokai theme
Plug 'tanvirtin/monokai.nvim'
Plug 'mrtazz/molokai.vim'

" window management
" Plug 'vim-scripts/bufkill.vim'
Plug 'nathanaelkane/vim-command-w'

" status lines
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" commands like :Rename and :Remove
Plug 'tpope/vim-eunuch'

" Git utils
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-git'

" Comment with gc (takes a motion) or ^_^_
Plug 'tomtom/tcomment_vim'

" file search
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" javascript plugins
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" handlebars highlighting
Plug 'mustache/vim-mustache-handlebars'

" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-tsserver', 'coc-java', 'coc-clangd']

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

call plug#end()


" Backups and swap
set nobackup
set nowritebackup
set noswapfile
set backupdir=~/.vim/backup
set directory=~/.vim/backup


syntax on
set nohidden
set history=10000
set number
set ruler
set switchbuf=useopen
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=longest,list
set wildmenu
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,public/javascripts/compiled,tmp,*.orig,*.jpg,*.png,*.gif,log,solr,.sass-cache,.jhw-cache,bundler_stubs,build,error_pages,node_modules,bower_components,coverage,dist

" Status bar
set laststatus=2

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
" set t_ti= t_te=

set t_Co=256
let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }
let g:CSApprox_eterm = 1
" colorscheme monokai
colorscheme molokai

" airline theme
let g:airline_theme='deus'

" Show (partial) command in the status line
set showcmd

set noerrorbells
set visualbell
set t_vb=

" Use modeline overrides
set modeline
set modelines=10

" CTags
" brew install ctags
" $ ctags -R .
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>

" jump to definition with coc
map <C-]> <Plug>(coc-definition)
" nmap <silent> gd <Plug>(coc-definition)

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" make uses real tabs
au FileType * set expandtab
au FileType make set noexpandtab

au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby
au BufNewFile,BufRead *.json set ft=javascript
au BufNewFile,BufRead *.hamlbars set ft=haml
au BufNewFile,BufRead *.hamlc set ft=haml
au BufNewFile,BufRead *.jst.ejs set ft=jst

" set correct filetypes for React
autocmd BufRead,BufNewFile *.jsx set filetype=javascriptreact
autocmd BufRead,BufNewFile *.tsx set filetype=typescriptreact

" Add typescript filename support
autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript

" Add css highlighting for .pcss files
au BufNewFile,BufRead *.pcss set ft=css

au FileType * set softtabstop=2 tabstop=2 shiftwidth=2

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

" highlighting handelbar files
au BufRead,BufNewFile *.hbs set filetype=handlebars

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Inserts the path of the currently edited file into a command
" Command mode: %%
cmap %% <C-R>=expand("%:p:h") . "/" <CR>

" close quickfix window if no errors
let g:flow#autoclose = 1

"map quick quit
map <leader>qq :qa!<cr>

"key mapping for window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" key mapping for line jumping
nmap <S-l> $
nmap <S-h> ^

" Useful for triggering a cucumber run
nmap <Leader>rc :silent !touch features/step_definitions/web_steps.rb<CR>

" Make the current directory
nmap <leader>md :silent !mkdir -p %:h<CR>:redraw!<CR>

" Show 2 lines of context
set scrolloff=2

" Make the window we're on as big as it makes sense to make it
"set winwidth=84

" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
"set winheight=5
"set winminheight=5
"set winheight=999

" don't delay when you hit esc in terminal vim, this may make arrow keys not
" work well when ssh'd in
set ttimeoutlen=5

function! SaveIfModified()
  if &modified
    :w
  endif
endfunction

"key mapping for error navigation
nmap <leader>[ :call SaveIfModified()<CR>:cprev<CR>
nmap <leader>] :call SaveIfModified()<CR>:cnext<CR>

nmap <leader>w :CommandW<CR>

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" Make sure snippets are installed: https://github.com/neoclide/coc-snippets
" :CocInstall coc-snippets
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Scala
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Use a local installation of coursier
let g:coc_metals_install_metals = 0
let g:coc_metals_coursier_path = '/opt/homebrew/bin/coursier'

" (metals is the scala language server)
" :CocInstall coc-metals
" coursier bootstrap --java-opt -Xss4m --java-opt -Xms100m org.scalameta:metals_2.12:latest.release -o /usr/local/bin/metals -f
" "
" Will also need to install a version of java 11 that can be managed with jenv
"   brew install openjdk@11
"   jenv add /usr/local/opt/openjdk@11
"   jenv local 11.0 (in the scala working directory)

" Metals server options
let g:coc_metals_server_version = 'latest.release'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Java
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType java setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C++
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType cpp setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType c setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" Setup compile commands for C++
autocmd FileType cpp nnoremap <leader>b :w <CR> :!g++ -std=c++17 % -o %:r && ./%:r<CR>
autocmd FileType cpp nnoremap <leader>r :!./%:r<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't manage working directory
" let g:ctrlp_working_path_mode = 0
"
" map <leader>f :let g:ctrlp_default_input = 0<cr>:CtrlP<cr>
" let g:ctrlp_custom_ignore = {
" \  'dir' : '\.git$\|build$\|bower_components\|node_modules\|dist\|target'
" \ }


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF mappings (replace CtrlP)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader>f :Files<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ack mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>a :Ack!<space>
map <leader>A :Ack! <C-R><C-W><CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ARROW KEYS ARE UNACCEPTABLE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
map <Down> :echo "no!"<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NerdTree mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-n> :NERDTreeToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tmux stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('mouse')
  set mouse=a
  if &term =~ "xterm" || &term =~ "screen"
    " for some reason, doing this directly with 'set ttymouse=xterm2'
    " doesn't work -- 'set ttymouse?' returns xterm2 but the mouse
    " makes tmux enter copy mode instead of selecting or scrolling
    " inside Vim -- but luckily, setting it up from within autocmds
    " works
    " autocmd VimEnter * set ttymouse=xterm2
    " autocmd FocusGained * set ttymouse=xterm2
    " autocmd BufEnter * set ttymouse=xterm2
  endif
endif

" Fix for powerline issue
" https://github.com/vim-airline/vim-airline/issues/2704
" let g:airline#extensions#whitespace#symbol = '!'
let g:airline#extensions#whitespace#enabled = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Preview window size hack
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ResizePreviewWindow()
  if &previewwindow
    set winheight=999
  endif
endfunction
au WinEnter * call ResizePreviewWindow()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vroom
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vroom_map_keys = 0
let g:vroom_write_all = 1
let g:vroom_use_bundle_exec = 0
let g:vroom_spec_command = 'NOEXEC_DISABLE=1 rspec '
map <leader>t :VroomRunTestFile<cr>
map <leader>T :VroomRunNearestTest<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Copy paste system clipboard
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>y "*y
map <leader>p "*p
map <leader>P "*P

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fugitive
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>gs :Gstatus<cr>
map <leader>gc :Gcommit<cr>
map <leader>ga :Git add --all<cr>:Gcommit<cr>
map <leader>gb :Gblame<cr>

" Use j/k in status
function! BufReadIndex()
  setlocal cursorline
  setlocal nohlsearch

  nnoremap <buffer> <silent> j :call search('^#\t.*','W')<Bar>.<CR>
  nnoremap <buffer> <silent> k :call search('^#\t.*','Wbe')<Bar>.<CR>
endfunction

autocmd BufReadCmd  *.git/index                      exe BufReadIndex()
autocmd BufEnter    *.git/index                      silent normal gg0j

" Start in insert mode for commit
function! BufEnterCommit()
  normal gg0
  if getline('.') == ''
    start
  end
endfunction
autocmd BufEnter    *.git/COMMIT_EDITMSG             exe BufEnterCommit()

" Automatically remove fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quit help easily
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! QuitWithQ()
  if &buftype == 'help'
    nnoremap <buffer> <silent> q :q<cr>
  endif
endfunction
autocmd FileType help exe QuitWithQ()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Powerline configuration, you'll need a powerline patched font.
" You should probably use inconsolata-g (included in fonts directory)
" https://github.com/gabrielelana/awesome-terminal-fonts/wiki/OS-X
"
" If not, you can patch your own.
" See: https://github.com/Lokaltog/vim-powerline/tree/develop/fontpatcher
" You'll probably need this too: https://github.com/jenius/Fontforge-Installer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:Powerline_symbols = 'fancy'
" let g:Powerline_stl_path_style = 'short'
" set encoding=utf-8
" set termencoding=utf-8
" call Pl#Theme#RemoveSegment('fugitive:branch')
" call Pl#Theme#RemoveSegment('fileformat')
" call Pl#Theme#RemoveSegment('fileencoding')
" call Pl#Theme#RemoveSegment('scrollpercent')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This enables iterm cursor changes from vim. In .tmux.conf you'll need:
" set-option -g terminal-overrides '*88col*:colors=88,*256col*:colors=256,xterm*:XT:Ms=\E]52;%p1%s;%p2%s\007:Cc=\E]12;%p1%s\007:Cr=\E]112\007:Cs=\E]50;CursorShape=%?%p1%{3}%<%t%{0}%e%p1%{2}%-%;%d\007'
"
" Source: https://github.com/Casecommons/casecommons_workstation/blob/master/templates/default/dot_tmux.conf.erb
"         https://github.com/Casecommons/vim-config/blob/master/init/tmux.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" if exists('$ITERM_PROFILE')
"   if exists('$TMUX')
"     let &t_SI = "\<Esc>[3 q"
"     let &t_EI = "\<Esc>[0 q"
"   else
"     let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"     let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"   endif
" end

" fix cursor in vim in tmux
" http://blog.terriblelabs.com/blog/2013/02/09/stupid-vim-tricks-how-to-change-insert-mode-cursor-shape-with-tmux/
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
inoremap <special> <Esc> <Esc>hl
set guicursor+=i:blinkwait0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This fixes pasting from iterm (and some other terminals, but you'll need to
" adjust the condition) by using "bracketed paste mode"
" I modified it to work in tmux and not wait for esc (by using f28/f29)
"
" See: http://stackoverflow.com/questions/5585129/pasting-code-into-terminal-window-into-vim-on-mac-os-x
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tmux wrapping borrowed from vitality.vim: https://github.com/sjl/vitality.vim
function WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

if exists('$ITERM_PROFILE')
  " I'm just setting bracketed paste mode in my bashrc now. Setting and
  " unsetting doesn't work very well with tmux as it affects other shells.
  " put this in your bashrc: [ -n "$ITERM_PROFILE" ] && printf "\e[?2004h"
  "
  " let &t_ti = WrapForTmux("\<Esc>[?2004h") . &t_ti
  " let &t_te = WrapForTmux("\<Esc>[?2004l") . &t_te
  function XTermPasteBegin(ret)
    set pastetoggle=<Esc>[201~
    set paste
    return a:ret
  endfunction

  execute "set <f28>=\<Esc>[200~"
  execute "set <f29>=\<Esc>[201~"
  map <expr> <f28> XTermPasteBegin("i")
  imap <expr> <f28> XTermPasteBegin("")
  vmap <expr> <f28> XTermPasteBegin("c")
  cmap <f28> <nop>
  cmap <f29> <nop>
end

" Add racket support (use scheme highlighting)
if has("autocmd")
  au BufReadPost *.rkt,*.rktl set filetype=scheme
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LAST SECTION
" Include user's local vim config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" Fix arrow keys not working in insert mode
imap <ESC>oA <ESC>ki
imap <ESC>oB <ESC>ji
imap <ESC>oC <ESC>li
imap <ESC>oD <ESC>hi
