# dotfiles

Bash, tmux, and neovim configuration for macOS (Apple Silicon / Homebrew).
Reference machine: macOS 15, tmux 3.5a, neovim 0.11.

## Install

```bash
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

git clone git@github.com:kochis/dotfiles.git ~/.dotfiles
~/.dotfiles/install_apps.sh     # core brew packages (see below)
~/.dotfiles/setup.sh            # symlinks + vim-plug (safe to re-run)
nvim +PlugInstall +qall         # neovim plugins
```

Then open a new terminal. The default shell must be bash (`chsh -s /bin/bash`);
`setup.sh` warns if it is not.

Update `name` / `email` in `gitconfig` if this is not your machine.

### What `setup.sh` links

| Repo file          | Target                 |
|--------------------|------------------------|
| `bash_profile`     | `~/.bash_profile`      |
| `git-prompt.sh`    | `~/.git-prompt.sh`     |
| `gitconfig`        | `~/.gitconfig`         |
| `gitignore_global` | `~/.gitignore_global`  |
| `tmux.conf`        | `~/.tmux.conf`         |
| `ackrc`            | `~/.ackrc`             |
| `ctags.cnf`        | `~/.ctags.cnf`         |
| `config/nvim/`     | `~/.config/nvim`       |

### Packages

`install_apps.sh` installs the packages the configs depend on:

```
ack autojump bash-completion ctags direnv fzf git jq n neovim ripgrep tmux
openjdk openjdk@17
font-jetbrains-mono-nerd-font (cask)
```

`Brewfile` is a full `brew bundle dump` of the reference machine (includes
tooling unrelated to these dotfiles). To reproduce the whole machine:

```bash
brew bundle --file=~/.dotfiles/Brewfile
```

## neovim

Config lives in `config/nvim/init.vim` (vimscript with a Lua block for LSP).
Leader is `,`.

### Plugins

Managed by [vim-plug](https://github.com/junegunn/vim-plug). `init.vim`
downloads vim-plug automatically on first launch if it is missing, then
`nvim +PlugInstall +qall` installs everything. Plugins are installed under
`~/.local/share/nvim/site/autoload/`.

| Area          | Plugins |
|---------------|---------|
| Colors        | molokai.vim (active), monokai.nvim |
| UI            | vim-airline (+themes, `deus`), fidget.nvim, vim-command-w |
| Git           | vim-fugitive, vim-rhubarb, vim-git |
| Editing       | tcomment_vim, vim-eunuch |
| Search        | fzf + fzf.vim (`,f` files, `,a` ripgrep) |
| Syntax        | vim-javascript, typescript-vim, vim-jsx-typescript, vim-mustache-handlebars |
| LSP           | nvim-lspconfig, mason.nvim, mason-lspconfig.nvim |
| Completion    | nvim-cmp, cmp-nvim-lsp, cmp-buffer, cmp-path, LuaSnip, cmp_luasnip |
| Languages     | nvim-metals (Scala), nvim-jdtls (Java) |
| Markdown      | nvim-treesitter (`master` branch), nvim-web-devicons, render-markdown.nvim |

Useful commands: `:PlugInstall`, `:PlugUpdate`, `:PlugClean`.

### LSP servers

Mason auto-installs these on first launch: `ts_ls`, `eslint`, `clangd`,
`rust_analyzer`. Treesitter installs the `markdown` / `markdown_inline`
parsers on first launch.

- **Rust**: uses `~/.cargo/bin/rust-analyzer` if rustup provides one,
  otherwise the Mason copy.
- **Java**: `:MasonInstall jdtls`. jdtls runs on the latest brew `openjdk`
  (needs 21+); projects default to `openjdk@17`.
- **Scala**: nvim-metals downloads Metals itself (needs `openjdk@17`).
- **Icons**: set your terminal font to *JetBrainsMono Nerd Font Mono*
  (installed by `install_apps.sh`) so devicons / render-markdown glyphs show.

Check status with `:LspInfo`, `:Mason`, `:checkhealth`. Python/Ruby/Perl/Node
remote-plugin providers are intentionally disabled; nothing here needs them.

### Key mappings (highlights)

| Key            | Action |
|----------------|--------|
| `,f`           | fzf files |
| `,a` / `,A`    | ripgrep (`:Rg`) / ripgrep word under cursor |
| `Ctrl-n`       | netrw file explorer |
| `,gs` `,gc` `,gb` | `:Git`, `:Git commit`, `:Git blame` |
| `gd` / `Ctrl-]`| LSP go to definition |
| `,rn` `,ca` `,e` | LSP rename / code action / diagnostics float |
| `[d` / `]d`    | previous / next diagnostic |
| `,y` `,p`      | yank / paste via system clipboard |
| `,w`           | close buffer (vim-command-w) |
| `Ctrl-h/j/k/l` | window navigation |

## tmux

Prefix is `Ctrl-f`.

| Key                    | Action |
|------------------------|--------|
| `C-f r`                | reload config |
| `C-f s` / `C-f v`      | split horizontal / vertical |
| `C-f h/j/k/l`          | move between panes |
| `C-f C-h/C-j/C-k/C-l`  | resize pane |
| `C-f C-f`              | cycle panes |
| `C-f Enter` (or `z`)   | toggle zoom |
| `C-f [` then `v`, `y`  | copy mode (vi keys), select, yank to tmux buffer |
| `C-f C-c` / `C-f C-v`  | copy tmux buffer to / paste from macOS clipboard |

Mouse is enabled, scrollback is 100k lines, true color is enabled for
`xterm-256color` outer terminals (iTerm2 / Terminal.app).

## Other files

- `iterm.json` – iTerm2 profile export (colors). Import via
  iTerm2 → Settings → Profiles → Other Actions → Import JSON Profiles,
  then set the font to JetBrainsMono Nerd Font Mono.
- `fonts/` – legacy Powerline font (not needed with the Nerd Font).
- `ctags.cnf` – used by the `generate-tags` bash function.
