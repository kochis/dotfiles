set nocompatible
let mapleader = ","

set shell=/bin/bash

" install plugins using vim-plug
call plug#begin('~/.local/share/nvim/site/autoload')

" monokai theme
Plug 'tanvirtin/monokai.nvim'
Plug 'mrtazz/molokai.vim'

" window management
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

" ============================================================
" Native LSP + Completion (replaces CoC)
" ============================================================
" LSP configurations for common servers
Plug 'neovim/nvim-lspconfig'

" Mason: portable LSP/DAP/linter/formatter installer
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'

" Snippet engine (required by nvim-cmp)
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" Scala Metals support
Plug 'scalameta/nvim-metals'

" Java (jdtls) enhanced support
Plug 'mfussenegger/nvim-jdtls'

" Useful LSP UI improvements (optional but nice)
Plug 'j-hui/fidget.nvim'

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

set t_Co=256
let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }
let g:CSApprox_eterm = 1
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
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>

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

" make Python follow PEP8
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

" highlighting handelbar files
au BufRead,BufNewFile *.hbs set filetype=handlebars

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Inserts the path of the currently edited file into a command
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

" don't delay when you hit esc in terminal vim
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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Scala
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" (Metals config is handled in Lua below)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Java
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType java setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C++
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType cpp setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType c setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType cpp nnoremap <leader>b :w <CR> :!g++ -std=c++17 % -o %:r && ./%:r<CR>
autocmd FileType cpp nnoremap <leader>r :!./%:r<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF mappings
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
endif

let g:perl_host_prog = '/opt/homebrew/bin/perl'

" Fix for powerline issue
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

function! BufReadIndex()
  setlocal cursorline
  setlocal nohlsearch
  nnoremap <buffer> <silent> j :call search('^#\t.*','W')<Bar>.<CR>
  nnoremap <buffer> <silent> k :call search('^#\t.*','Wbe')<Bar>.<CR>
endfunction

autocmd BufReadCmd  *.git/index                      exe BufReadIndex()
autocmd BufEnter    *.git/index                      silent normal gg0j

function! BufEnterCommit()
  normal gg0
  if getline('.') == ''
    start
  end
endfunction
autocmd BufEnter    *.git/COMMIT_EDITMSG             exe BufEnterCommit()
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

" fix cursor in vim in tmux
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
inoremap <special> <Esc> <Esc>hl
set guicursor+=i:blinkwait0

" bracketed paste mode for iterm/tmux
function WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif
  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"
  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

if exists('$ITERM_PROFILE')
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

" Add racket support
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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Native LSP + Completion Configuration (Lua)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF

-- ────────────────────────────────────────────────────────────
-- Fidget: LSP progress indicator
-- ────────────────────────────────────────────────────────────
require("fidget").setup({})

-- ────────────────────────────────────────────────────────────
-- Mason: auto-install LSP servers
-- ────────────────────────────────────────────────────────────
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "ts_ls",
    "eslint",
    "clangd",
    "rust_analyzer",
  },
})

-- ────────────────────────────────────────────────────────────
-- nvim-cmp: Autocompletion (replaces CoC completion)
-- ────────────────────────────────────────────────────────────
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
    ["<C-f>"]     = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"]     = cmp.mapping.abort(),

    -- <CR> confirms completion (mirrors your old CoC CR mapping)
    ["<CR>"] = cmp.mapping.confirm({ select = false }),

    -- <Tab> to select next item or expand snippet (mirrors your old CoC Tab mapping)
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = true })
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
})

-- ────────────────────────────────────────────────────────────
-- LSP: Keybindings via LspAttach autocmd
-- ────────────────────────────────────────────────────────────
-- Nvim 0.11 sets some defaults (K for hover, grn for rename, gra for
-- code_action, grr for references, gri for implementation), but we
-- add our custom ones here too.

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local bufnr = ev.buf
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- Navigation (replaces <C-]> → coc-definition)
    vim.keymap.set("n", "<C-]>",     vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gd",        vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD",        vim.lsp.buf.declaration, opts)

    -- Actions
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>e",  vim.diagnostic.open_float, opts)

    -- Diagnostics navigation
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  end,
})

-- ────────────────────────────────────────────────────────────
-- LSP Server Configurations (vim.lsp.config + vim.lsp.enable)
-- ────────────────────────────────────────────────────────────
-- Global defaults applied to all servers
vim.lsp.config("*", {
  capabilities = capabilities,
})

-- TypeScript / JavaScript  (replaces coc-tsserver)
vim.lsp.config("ts_ls", {
  filetypes = {
    "javascript", "javascriptreact",
    "typescript", "typescriptreact",
  },
})

-- ESLint  (replaces coc-eslint)
vim.lsp.config("eslint", {
  filetypes = {
    "javascript", "javascriptreact",
    "typescript", "typescriptreact",
  },
})

-- Auto-fix eslint on save
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.name == "eslint" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = ev.buf,
        callback = function()
          vim.cmd("silent! EslintFixAll")
        end,
      })
    end
  end,
})

-- C / C++  (replaces coc-clangd)
vim.lsp.config("clangd", {
  -- uses defaults from nvim-lspconfig's bundled config
})

-- Rust  (replaces coc-rust-analyzer)
vim.lsp.config("rust_analyzer", {
  cmd = { "/Users/craig/.cargo/bin/rust-analyzer" },
  settings = {
    ["rust-analyzer"] = {
      cargo = { autoreload = true },
      procMacro = { enable = true },
      checkOnSave = { command = "check" },
      diagnostics = { enable = true },
    },
  },
})

-- Enable all the above servers
-- (nvim-lspconfig provides the base cmd/filetypes/root_markers
-- for each; our vim.lsp.config() calls above merge on top)
vim.lsp.enable({
  "ts_ls",
  "eslint",
  "clangd",
  "rust_analyzer",
})

-- ────────────────────────────────────────────────────────────
-- Scala Metals  (replaces coc-metals)
-- nvim-metals has its own attach mechanism, not vim.lsp.enable
-- ────────────────────────────────────────────────────────────
local metals_config = require("metals").bare_config()
metals_config.settings = {
  showImplicitArguments = true,
  serverVersion = "latest.release",
  javaHome = "/opt/homebrew/opt/openjdk@11",
  sbtScript = "/usr/local/bin/sbt",
}
metals_config.capabilities = capabilities

local metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = metals_group,
})

-- ────────────────────────────────────────────────────────────
-- Java (jdtls)  (replaces coc-java)
-- nvim-jdtls has its own attach mechanism
-- ────────────────────────────────────────────────────────────
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
    local jdtls_found = vim.fn.isdirectory(mason_path) == 1

    if not jdtls_found then
      vim.notify("jdtls not found. Install via :MasonInstall jdtls", vim.log.levels.WARN)
      return
    end

    local jdtls = require("jdtls")

    local os_config = "config_mac"
    if vim.fn.has("linux") == 1 then
      os_config = "config_linux"
    end

    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = vim.fn.expand("~/.cache/jdtls-workspace/") .. project_name

    local config = {
      cmd = {
        "/opt/homebrew/opt/openjdk@11/bin/java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms100m",
        "-Xmx2G",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
        "-jar", vim.fn.glob(mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
        "-configuration", mason_path .. "/" .. os_config,
        "-data", workspace_dir,
      },
      root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
      settings = {
        java = {
          configuration = {
            updateBuildConfiguration = "automatic",
            runtimes = {
              {
                name = "JavaSE-11",
                path = "/opt/homebrew/opt/openjdk@11",
                default = true,
              },
            },
          },
          import = {
            gradle = {
              wrapper = { enabled = true },
              java = { home = "/opt/homebrew/opt/openjdk@11" },
            },
          },
          saveActions = { organizeImports = true },
          errors = { incompleteClasspath = { severity = "ignore" } },
        },
      },
      capabilities = capabilities,
    }

    jdtls.start_or_attach(config)
  end,
})

-- ────────────────────────────────────────────────────────────
-- Diagnostic display settings
-- ────────────────────────────────────────────────────────────
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  float = { border = "rounded" },
})

EOF