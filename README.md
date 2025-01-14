# README

Some dot files for some tools I use. All of them belong into `~/.config/` folder.

## Settings

Some of the settings might not work on your system because some additional steps are required. 

### Neovim

In my neovim settings different LSP's are listed which neovim will try to install on the first startup. However you might not have installed the necessary tools for the language the LSP belongs to. For example if you haven't installed `solargraph` the Ruby LSP will not work and therefore throw an error on startup.

You can either:
- Install the necessary tools
- Disable the automatic install

If you want to disable the automatic install you can edit the file `nvim/lua/plugins/lspconfig.lua`, specificall these lines:

```lua
require('mason-lspconfig').setup({
	ensure_installed = {
		'clangd',
		'texlab',
		'marksman',
		'rust_analyzer',
		'lua_ls',
		'jedi_language_server',
		'ruby_lsp',
		'sorbet',
		'ltex',
		'typst_lsp',
		'gopls',
		-- needs to be manually installed: 
		-- 'goimports',
		-- 'gofumpt',
		-- 'gomodifytags',  -- Modify struct field tags
		-- 'impl'
	},
```

Just comment out whatever languages you don't want.


### ZSH

For zsh you need to link the .zshrc into the home directory
```bash
ln -s ~/.config/.zshrc ~/
```

There are also some non-standard tools which are either used in aliases or for more functionality in the .zshrc config file (list might be incomplete):

- Aliaes of standard tools:
  - `rm` -> `gio`
  - `cat` -> `bat` 
- `zoxide`
- `fzf`
- `asdf`
- `fastfetch`
- oh-my-zsh
- zsh-plugins:
  - zsh-autosuggestions
  - zsh-syntax-highlighting

> [!IMPORTANT]
> On Ubuntu/Debian `bat` needs to be changed to `batcat`


## Note

> [!NOTE]
> Create an issue if you still encounter problems
